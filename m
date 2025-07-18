Return-Path: <linux-kernel+bounces-736096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3DB098C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F454E4660
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2303C38;
	Fri, 18 Jul 2025 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X58n9jiK"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3991C36
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797586; cv=none; b=oad5x/HrwcoLwo5a0K8MWMlbxrCXxp/hPPr1RerhjjH9zBFKZl99RYZONz1jolYwDgC+QjgcmTUSF8JT2CEp3/mXnr9JZki2tqSf30Pmf2hSKrYSMfDskFH4+m75YrRhNu88AoTRl+iXdEvjeTw51pK4TKZZkLWnP5iv27vlOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797586; c=relaxed/simple;
	bh=6t9mFeIyK0lgwRT1Gf85ovoZIAqCNFovrJc1rs7GQKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rye3AQ1X8RU9VKqs+KWwYtQS+NO5KzGrBvvcPp5se3Bl+Q7Nq+sE0pw+j66F5GSNMqKtX3RvjCNcVZYAl6iE/i3BIAvUL4/vlawgfK/WfgB54jGvJQzC9jxSotz3LCKC5g2G12yHbiMbeHORfjwN2tWhkEHblsJjrmvYo+6M80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X58n9jiK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-612b34ef0c2so1996729a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 17:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752797583; x=1753402383; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbM8/Vwi/mX+eyTIY7G78RqsGKZx4977hGFjLuxa+1o=;
        b=X58n9jiKvrQQjlXm6S1ZrfEJ84nMVKtDk8qG3LEo/mpMo6yGz9/B98wFBiGoUw9Huo
         KaNQKCZPnNZcXBQ8dlxnORkwxnN58oObW7KWGuRX0jxGRy06NnvmillvjBaFBITy6W9t
         FBKkbbhezxhCdlgUfzvgk1dN14f/ZLsY2fufKcj5+9ueDs9LG4VJjTZOdT0udwKC5lH+
         PVbk2ADZBkpipjdhxNjFA9iD5RojoVrzQupQaQa/zTuMZi8sU0N60YBPJ2UeYGq+4V4r
         U1qE52SJGuv/EEXty2V6sGSfKegC8IEmLaV1LrZyHFl77HzWtKY9VSTTa8jpY1qshzYd
         QX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752797583; x=1753402383;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbM8/Vwi/mX+eyTIY7G78RqsGKZx4977hGFjLuxa+1o=;
        b=g3a2TkXSYnt+unQ/LO6bJCYQNbqJHm3IVWhLgtd7sim2Im//Wa+qte2k63g54cXZ0g
         32Xtyq0MB7XSennTMzZbS00xxaCkuQFe69Z1hs7bTscYPqASsLaJjitcO3HNUtXS/WnJ
         Bz5rzxUOSs/4+2rZyfiJLqohQsbfOGpL5XlaQuNp1t/0YSTba2PUdCXZJnSbKoGli7Lz
         0cp9glKl2QVPsv7jOPWebANt7/fWEsoGhtvFj4/wbjzFkCOCg2FQ+jAtP4h45kXd8KeO
         rcczDs4YSq0a8v/qtb7jUEP/Qi0xSjWDGmP8qfLO0MsIQdJBXMSUyfd/t8wCRjJkAtah
         BLHg==
X-Forwarded-Encrypted: i=1; AJvYcCWDj6HoWyo6Ydip10qOanABSH2gB83bOMR7ahS86NOn1szGVF+bLCTIAonI+EO+qcmFWlZ25PDchgIPSzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqV3qIFhzrshz4IB29ipw5L9b5z4l3xI2obUi+yEwC4Ku92i1
	+4av3tU8fmtYl9QvoIlon9Q70eOYNqU6ROFNeZtPREzLPiwCyy2Ifc0I
X-Gm-Gg: ASbGncu0f6GINvnu8OErgKMUo1H8HWfqeWa1oCo7qE/h8x28roO1DLW35AaHlK4TvUu
	RU5HB/nZ4eswuLctEODiHDaBCOxtrpTLtmkrf3TcPK246kaQI/wou+Pn4Xd2fByHa21iPC0ENB/
	4gbnr9N2NjRrVEQjNiyydbfg15cCydSUrHegIf7HqnNMml6MGdpkLrZJ9evJM9jSS2wIzUbZku5
	Pi+N1YHhhOORw39Q5UkEuvH0ji+vnEZPaFbXNi5j0wlp7vmtpBHeRkTKomuOoGoeGtGhG5syfyI
	4SH4GroNRn5Rgtzla6MG085Li6kXW22KAQSgiMBbwrvnS3liUV7sQ+tSukHSiMW6Uw3VkNL7JkW
	ns54CBvB21IZmvTzc07Ys5g==
X-Google-Smtp-Source: AGHT+IHr0GFFwWdGfnvudm55E0zDB3NLjTO6ie+bKmRkwHaBngE5Gl2UdoWgqBIWtdQHWUkmoxHlHg==
X-Received: by 2002:a17:906:5292:b0:ae3:a8ee:59ea with SMTP id a640c23a62f3a-aec4fc8bbb9mr454959966b.54.1752797582961;
        Thu, 17 Jul 2025 17:13:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf7e78sm19614366b.158.2025.07.17.17.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jul 2025 17:13:02 -0700 (PDT)
Date: Fri, 18 Jul 2025 00:13:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, broonie@kernel.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, sj@kernel.org, ziy@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
	Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com, richard.weiyang@gmail.com, ryncsn@gmail.com,
	shuah@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH 2/2] selftests/mm: guard-regions: Use SKIP() instead of
 ksft_exit_skip()
Message-ID: <20250718001302.57xrgn7mh5x3nkkk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
 <20250717131857.59909-3-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717131857.59909-3-lianux.mm@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 09:18:57PM +0800, wang lian wrote:
>To ensure only the current test is skipped on permission failure, instead
>of terminating the entire test binary.
>
>Signed-off-by: wang lian <lianux.mm@gmail.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

