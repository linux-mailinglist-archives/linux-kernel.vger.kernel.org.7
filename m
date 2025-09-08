Return-Path: <linux-kernel+bounces-805250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159CCB485EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7F87A55FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B02E8B8F;
	Mon,  8 Sep 2025 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjlM0ocH"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8F2E1C7C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317473; cv=none; b=BZu8NrCsPLNy5plqk1JQQ3pRzI+HencRXv1Cs+o+2VYEowYgG26W7kVfHS6zjTnzzs4IU0uaiuh10cJaZsksK9CMyUICgXi2RyjnEeQkMmoR2QmruoroX0vNBIufGOGgnmSDiI64WR7ZeAs6Ng8175FCS3kHt96FCYKwtdf+9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317473; c=relaxed/simple;
	bh=kL9UTFTOwTwX7nZq68SlUX6QKXEKpUN3PiqwtgfOUMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKhm9+VX8y1RHH8xZq2PgeTnPaVxYtPR0bGSMnjHFKWPaN3euN3emE6mmd7ohqC0lZV9UxlYtCL5zhC6HtQD+RwpW8R46yVENSlHByTrD9bTe3wR9BW+IZal7ipElGV6GK1EDEP/Ehz4IlGW0S4QD/y4NxiGe0vXwWp6bqGD0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PjlM0ocH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c89867a17so38859265ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757317471; x=1757922271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=toUuFoyYxtz3IY7Dj5fLibZ/IZI1MSArfETrATESfNs=;
        b=PjlM0ocHddk63KZJkHF2qkBkHMt4paRFXVv2/rJEgyvmroC7mZdi02D+SNhvGKS0GV
         k9qoquLZNvDJYpk7LqjBQv0ZGIbxwQKnLpQlMqv5ML6QFol6I07trUjTBPvFld6SzzJ8
         WlaFxVEAcc1kCtNsCe4i2MBp9qYDMAd9YBZWl5KYVg0bwz7/KXRKR2f9dbBwtgY0Sfv1
         d+J7NHBYkPxm7IJzizpsBDbgH9fus+rO0g8cZd6o/TYXWh56wetblw79z8g+FeHliBMa
         CYz+RHqns7gTs3QnPdOGzcEp6C7reS/eDIOg10huQqpNcierYFsAWAMdMSaEXm1eCxI6
         AdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317471; x=1757922271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toUuFoyYxtz3IY7Dj5fLibZ/IZI1MSArfETrATESfNs=;
        b=XkEW5Y/wGcJUJqogbSXPgIjyzH/oE2DpRT3Xi0lfvZ21tZ85xtOpECbhmNmPo1I48I
         xHbTLWXxAsTKKDiinxhRbGEtxVh8Zv03SFLUQyJtb+fli6WLGUzS3OBmYGKk7PVZWfEx
         zKT/ortDOIYa6aQzNgraIKDu2VW5VLidQAb1YwJ4P8rZUQfrI4d17IGBKcyCAoD+PEIk
         +GWJlNwkmEX+KtyaMIUdydNm5ZZB2wljsEUn3S5/09qVPGkav4+IPTHLsJ6mASdUDzd2
         T9tDcMVnwFH/71pX8BwIGAYBSuTpq1h/PR80x8q1v21JECWvvZX7XaVjc3DcC5A/HJpy
         bIIw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+L4NyqY/aBTm59LfsFtrJ8+NaLYZ26nnH7oBLUCMHx9Msw9Df0eyLLde61Tj+ZyBFDxL/fbbjpA80EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbBQ15s3Gitzwj+GNfx5YvqWCBeNrBqexvTldRvJPHt3hQJ78
	QKOnLFbfxSmFRhpaOiAx7OVKZ+IYFGwT5LffEgLq86TAUMrD3oWid/BhSRfR0w5HYnw=
X-Gm-Gg: ASbGncuSPqXecoif3dHuykhKTX/9aHNsMXHbO/AuCAQwhiwWb1Jz7+MqVu8EHJS+uU/
	MpK2XGVfFqTzJhPaaFuKgB1c67yMUGraVj12MUbgiE03wchufTQJms27Gc1O3omOxmmtEtIqPeb
	aaPHvLUvzfv9wJKwJViXOL7xQezKBSrzQqNy4y2DTPkdC9QsqftwRG1XUCnLAWfWwlJRg/hyDug
	7giaZj4gQfDksDcnc19EayAlwcqNN3CH8z1xFSclapOh3AOF706HQmhBXb1P91bIuubz1KF0Qmk
	2iwyPr+JxE4CYV1zcu1Nrk+ryJfyPfhpvnpQPUPdhSHP8amkAiJoQsFNm5G59cU2tnsFG/wUkVX
	wkHu19htCZkA3ZpDusBD6un8w
X-Google-Smtp-Source: AGHT+IGIUDY6HrGYjiBungp/6EW1xfUx0j7BBxotRNf1vw4rmkBz5kB6JcC1rC02ZIp6g3hIMeuaDA==
X-Received: by 2002:a17:902:ea09:b0:246:7a43:3f84 with SMTP id d9443c01a7336-2516d33d4ebmr104112085ad.5.1757317471368;
        Mon, 08 Sep 2025 00:44:31 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9e39094dsm131335155ad.84.2025.09.08.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:44:30 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:14:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250908074428.tphy4u7vjhkehwxk@vireshk-i7>
References: <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
 <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
 <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>
 <20250908065551.d5jhp5ejix4fzgd2@vireshk-i7>
 <67b55ae1-60b0-4d54-8220-59f7e3ba7c29@kylinos.cn>
 <20250908071920.f6ppfr7shy2cb2wg@vireshk-i7>
 <fecd3bf1-c8a5-4514-b3be-311a09abe5a9@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fecd3bf1-c8a5-4514-b3be-311a09abe5a9@kylinos.cn>

On 08-09-25, 15:36, Zihuan Zhang wrote:
> For instance, we could enforce that a driver cannot implement both
> has_target and has_target_index at the same time.

Can be added.

-- 
viresh

