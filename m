Return-Path: <linux-kernel+bounces-764447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D6B22307
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD1ED4E431C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157C02E8DE7;
	Tue, 12 Aug 2025 09:25:39 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1C2153E7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990738; cv=none; b=WWANe7cHbgbEnx9OFM20UsBu3uRJJAjZYzwPj423yWPenXa4l2E8d+7hDffsDhY04kfApCskjcgEC1mw3lh1kNZ4jk0um8BEh47QhfAoJjkuxqoNzXLvaNkC87mQInbJTfnSfgm9BYCuUPYxYzi7jM5JmOCPG1Wey6XiLo1CpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990738; c=relaxed/simple;
	bh=enLxgPUCcyxSZacElMM+MJHRs1HuYNtDkhMjWXsdeqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGYoHMoOAxRU2/SOI869d/hjE/lSKFeR3XGqUZVJgjqUOTAtUe1QBlXezdXvAhxK9n6Na4/ANieIglVbkB3BocGNsgP2FnADYPCUup40eSuJAsHGrL76SyIVnXJDXJsqz9/CFWAGobTyjIjDQAHOncleyOtLZXaNBewzgNkCNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af93381a1d2so833854566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990735; x=1755595535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RViPLn3T7bCa4lOx7TJxtYn2OtLfGzmGnGFGgXxcuDI=;
        b=LJZFclLGIFx323zFiQRQ0IOLEzAn5hm3nr5J8mjd6eDpE4RkRwvVFoDrz83k5iLdag
         oNx+SFMlsaCv37AVzk9tg7ZM2ynquXeCN1BuEFfAvbYVH1bb8+ZvakXE1aSaCFiR4hm7
         gGmumz8ClbKLgMRvI+teEZ4G8BhUXjtaMH0RcgQjHQ5ax/fKPeKGB0XkHSYD9rPa7Cay
         K0LCRL0yXZ/waT8sjAb4E5a0TpksY/kxGHiZB/2Pdrj0mr5vcuAuNb3zBiHlWAG3ntTl
         59IhlZDKWuENejyFe+xBGpGBoJGLgeuA8diiJs83xoqMFm4zBaVdiu/EYdWAZibHxqZz
         a7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVmFQOR+7zP4i1QAM9djZivdpZ5PZ8V9Htba4ieDu9r7inxAUTp/rrWT1uB68gHnkOegnIyk8wRgqQIrZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4qZoxNfmGYLWqIjKdxIDVTWas0MflEOO6ne/7v0tiRrXD9WW
	L3/GZew5IS1LkMGjQhukSfmxUhikJKqE0CD1jv/6idC+B54LdtWAntdA
X-Gm-Gg: ASbGnctGZp8+J2RojcYLB/KVQc9+etphCoZIfSnhrLU316KsdCYMUMsgGOTbVwHKIX+
	mPBCsigUHmRi8gbB2YLEXj3JH/4Ebp0r8KXwjL8w88jtZI9goge8mMTIUXQyYhVXgBYw8OzcoHg
	SrpIwwtqY8DLoLgUxJGXYMjRmDwlpVFcRH1A5pZZRTk17PZXA396CdAS+lwzHBvjB2eBvCyq92L
	9YuG6gU23fRUyCsG8jhnqaOjhp3vL2YaK10f45jFayHgHwbwdZWjOTyxtHcES4Qt7plDdr+LuVm
	jXvy9tHBkD5h7QoSxkgAtWC3dzZNRkRYcip2WXQolrR3oCg5bzqrL8+cpzf5g43VAHSmWmbf6QU
	nqChDKFi5Q8T6iw==
X-Google-Smtp-Source: AGHT+IHltuDZFQsO8zfkbxk5mhLpA9deyLdBIWMR6TIqWrUZou/kNbMNro/4Cnm7M2vj4Kj3NU0Gyw==
X-Received: by 2002:a17:907:a4a:b0:af9:57ae:dbb3 with SMTP id a640c23a62f3a-afa1dffcb78mr231159766b.22.1754990734413;
        Tue, 12 Aug 2025 02:25:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766d1sm2180448066b.18.2025.08.12.02.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:25:34 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:25:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: a.hindborg@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <hky4b3isz2eekz5nr43zstjm3tdho5kyd2pvqvo3t3uk3mhkgz@dzhev2rg7ekc>
References: <20250812082709.49796-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812082709.49796-1-zhao.xichao@vivo.com>

On Tue, Aug 12, 2025 at 04:27:09PM +0800, Xichao Zhao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

