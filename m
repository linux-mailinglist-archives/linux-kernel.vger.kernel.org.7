Return-Path: <linux-kernel+bounces-781161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B85B30E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE3B720135
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AAF296BAA;
	Fri, 22 Aug 2025 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKSkw1h+"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514872E2DD2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841958; cv=none; b=GXsMfKiakqz2heGpMJjGztjyTIvOiLGEMWEDOcgvJClF63P7pXt5zzG3kXwww/p0bwaVIPY8XAA+R0jYj3lnOdO0jnlY/rV5njX4DS1/O8Vc0FL+FBm1wc5maVYfXnHYCV0iC6lAyudVUc/Y9yxDltAYtPeTU+Sz6bH+l8kd4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841958; c=relaxed/simple;
	bh=7uX8JWTac+f6ksh/wu4QfEa5tteH904VkAXQGClcFe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1LIJ2jpKVu86O7cO/SWcbV3tx2JkR+ELZlQuCD3lNb8FStzaNz9rAEUO7pUD/bpenYWKhFv1ASXvIX1/u2mfZB7VqIcVwL+jexcXe0n2UeD974k9two8bh1MbJT1APCOQfxnzEWuDxegS4cZWv6tb6lP21lsdaa01QO81KaTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KKSkw1h+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea79219so2145496b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755841957; x=1756446757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YovWw4m77QAU1eZq6mNcpwZ3XWg61x3JgwqV7QjcnZU=;
        b=KKSkw1h+PeDrRCNUpBjn9Oqzl16HrJGciNVN5EjJl6uArPltvVdH3aHPGYrZVrJgHC
         G/0RJtFz2xDAJPrGw+g1f3D2IRD+lBMWOaugUk8WCgU/bjQfNYG5VmKGc1Cg3Tom9xTO
         mnMDX5a+ycrKegNJmNqpOuBBF6pnfGoWvTRfMEUZ5aJtGDBrgOGSAZh4oCb7j9cpE5Pv
         kFRUZ+lWSVEgxowrDI8mMeGhr2srFCuqvAN6g+4JYv4c+9SrQFDUCZ+/T+RrZjJV9dF7
         PnEj2FfIMy/qGQ4H9N5c7YebPPecPc3++DCRR2HnyjL3wGVlxgr5rkPUABZchDKzhvA2
         yqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755841957; x=1756446757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YovWw4m77QAU1eZq6mNcpwZ3XWg61x3JgwqV7QjcnZU=;
        b=gGY/jT866uxVay8/rMHPQ9GZ6GQLsHBypczNDRnRvufPFPmOJeOZvghzXiQKK39BSD
         7lTN0SZ4ZR3bLJHEDEtg2L3RYCXyB9VRIpug/fhqjDSILfI6bFgejCFFcMC98vZrrWaJ
         rD6O49Ic3ZRdrXpOFmd0l29EmizEo8p9UN9dx17pDPmahfU67k02zUkJlq0aOCEPwJ/Q
         o/hoJmDyxNkfHhClD/jVe7oG7x/W+48L0lQppJAI6MHA/aaeD50xsn6jx9yP6u5Fu19+
         nisnwMuCrOoe23ltnVVODf6C1M6/BXc3bJwi7PN0WSnyxnrSpQveogDouu9LUWursiDb
         E1IA==
X-Forwarded-Encrypted: i=1; AJvYcCU5BHHfxJRB1CbdGvlurTF47rnLjdtTBNcAj1S2fPmsXcvN/ilYskVYFWH54IE1+3V2D4FyR63xzhSMmHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWWXNMzmfvdILhPQF9eUOvHt3Y201UAXRvsUMtK+HcxRy2IN1
	ENueD0p0y4aG0ZSgmCXA/ngK1r8rwbNtADlt+vWS11F2D8YJCIpbQlZZXxZGxLfY9pw=
X-Gm-Gg: ASbGncuV9/VJWB6ZijH8gZPhEoBg+0HffpdJHcMXW9CLTzR/vjiOE7hvCwWFZv9JptM
	wW4mgES24OBcKHNlHcBvDZmXZ4DKG8e5BcsnNzwxn5zyrRal/4zwRYoDmISropLJ/WsJnclhNvR
	9TOdM2GED2TVOYvDCwXpBqo1jBW18QIQLdiqk4UoSqkkD1n5jepoxbvLRiK1nzGeufjVsTpaZim
	dyJvUn66ls1RQFjm/PKlmsNAOwG7Egqijj5eoKweRIKa1CSdwl7cIUGU5qtrIr8+JBYzcESOkxn
	Q2uwdtc2sp62K4qNTrHCuq2xTql9pBt7wUq/FfHbBOPRvRbJ1OkbwpKkjk0tBfa7Y3vYkhvjjHd
	z7d10bWTCmsd0OYeXOpVzCn7g4PbLYMHcgAg=
X-Google-Smtp-Source: AGHT+IERMmQ5QIMLdzGNTUZWTWABVarbRh+hsNdg9Eto0PuDHGxQR+AsczHzwOmYsK59MW3cwZ9ykw==
X-Received: by 2002:a05:6a21:3299:b0:232:fcfc:7209 with SMTP id adf61e73a8af0-24340e197afmr2543328637.35.1755841956381;
        Thu, 21 Aug 2025 22:52:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77037ae065dsm199357b3a.4.2025.08.21.22.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 22:52:35 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:22:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <20250822055233.otexzvta35jjnqrb@vireshk-i7>
References: <20250821091606.7470-1-work@onurozkan.dev>
 <20250821092137.wttiixhiidt27hnq@vireshk-i7>
 <20250822081343.4041a3d5@nimda.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822081343.4041a3d5@nimda.home>

On 22-08-25, 08:13, Onur Özkan wrote:
> `ret` is returned at the end unlike other `to_result` usages in other
> functions.

Ahh, I missed that to_result() doesn't return `ret` at all.

-- 
viresh

