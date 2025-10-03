Return-Path: <linux-kernel+bounces-841547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79638BB7A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14941B2152A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD2B2D47F5;
	Fri,  3 Oct 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLs1dWAw"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043572D47E4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510625; cv=none; b=PwL4G4j4FQDKG6Q/QPvxRFK3JLnGcTp80F8hvQJ60UC+iDZpi7EU0i2Irf/VKQ8RIcduIC/BVXJykteLiD8TtUTRTSyyTeC7JOjit3ntsITLYOUUq3x95iiBFm/LzJD+iYmvjiAOL2sD3exiHPe9j62Z5o3Bpwi3IFxU3eI9Sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510625; c=relaxed/simple;
	bh=lMe9n0d5sSzKYHdDwJLR25j7FIgPT6QfUdwsLq8bVKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBnSdteTneybwcHNnmltL+MzaxlZcM1qkuRsUsIwG5IBigUJWnB3fyd0pwR0bJPFcv/x8s48IjAFYV4lOE4pRIUukPJ/oVJvRFIVJiokAM6QkqGjWu2jHltRraWiysT6XA8xeGO0OHgHdCMcrTlCf6uGex/1P/QyBdppXN9SZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLs1dWAw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2731ff54949so5105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510623; x=1760115423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMyWZ863unvcPCDfDbJO8u6IlwG6EGLoHToxqTnNLVU=;
        b=ZLs1dWAwDz+KGBngSkA92eE00u4nonjRBAUtRcnFo/ZD22Sk1/08xM7WnZQ/oqiskf
         euKjwt3nMqYqMfpzalfOPRB1rTY0wxzmPLDmDzss1nHGI5PqTRAqVkjYuh0NGtEK7W/8
         hOR+lhA48nrqKI9DgoKwaeRQ/gMWRv1QeSONZTXicB2fXiOXo01lU8Vs59JqCb48GAXY
         /poHK22eDQk1Raw3g3rAoAUCfSnN53VUwEd2umk+jWBPfsnR440KgTYHagWK5/CDr9ln
         iGDKd+dGrZQY7T1Ky1yGm7Lk9i290qRmSB5iI/I1tUqPasmjlAbEOjpwF2KkC/AefD56
         XUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510623; x=1760115423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMyWZ863unvcPCDfDbJO8u6IlwG6EGLoHToxqTnNLVU=;
        b=bj458QTlUIoHq9iwKv/q2b3s+Yj+BQFvecAtMElmMeHmTD0fzXkLz1GF9PXD/DKZv8
         GxmoDJ6D6QrF0XTJu/yHtyHYJYq6Za87w/+JdeC3bcTpcOlsCuyJTacpbdz/DmUsegBI
         4AL4ao9prVT70NianzbEtfYG1enibDRPkHIF0Yh9BmG3fys7vYnJscCYe1P1Zw0npx6f
         ybLSc0ZCzpkJl62HxMKnGRCz/TPgpRN85Cyfm94dTqEDgA/94+BWXXqiS84q8GxdCmYx
         Dy8Zy3UZ2c1VVaIr3iD++gKlvsPHfzK8No28O2dwUcizLYZmKOvBTuJAR6nmdYQESObh
         zYng==
X-Forwarded-Encrypted: i=1; AJvYcCX/XdIzcp0a+L9XSylw474wYqVN+b15ThvIBnYPeWYUTDGd7uCGbv9SWkj0MQHJsSYdIG9c52RlnIEbMds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9yXBXR6tTB9D1tXqlDfsIejQ1x/EvL5L5ltPr9X64ZYnVXk2
	BgdFmJ6DOECExj1YKP4vHexX4F6P/yxQMJaByTeXseBCo1Mhh7YDJU7A5fm0c3im6A==
X-Gm-Gg: ASbGnculYEgJFyyrN8v2ZegKI1Q28K3wU2uE49iEHpAakWXq1L4sQV+8vORCluJA9kL
	2uOHpAFOcPgQzvDrCnkEOTX5qfD1gck01HWxsXP/6Jz+BjLW05k224pSiTFvBMKkcPw4vQHB+gD
	CIYRYPm0nfiABwgZ3jc4hZWF5nRlYYkhhf7vsRFXtm/84w/d9cvazm0YTtxbxvumq2dK+wihhhi
	Wm7tONUe3445NgHP08LqJS7/DZWDo7aibFindLzwUOrfsBuANZ2efVQgBhDJy+qPyuNNuyQvHpW
	tYQ2QREemVBdw+BUrCxyEeAp16R17rmYbMUNm0/hVIgDl8KUVKFUf5bxT+Df9IWLC8ZWyNgaDUY
	AJrlLhve/sr2B7nVa30AZNuY/0EAwxKz9ar+hxyVxfaWgMzHBSDaHAaYn1oIAlcgLg1HyN8hgW9
	WpEo5cq27IJ4Dy0jPIdi8vjj/NAu53LHjuZruRon7RRb/q9MvCdd+dAJ1sPLYtJ1BbxkB6o1Wyn
	pwfNUAQrDpR5J7t8fU3AVE=
X-Google-Smtp-Source: AGHT+IG+3R2E6MksfoEO03MOYAJXmn2CuVSf7IYlgVnyoDrESLkh0VUQsTS+FkPO/2IiYjaaeJTkog==
X-Received: by 2002:a17:903:1ae6:b0:266:b8a2:f5d8 with SMTP id d9443c01a7336-28e9a587c36mr4684585ad.14.1759510622768;
        Fri, 03 Oct 2025 09:57:02 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e6ccsm5372850b3a.63.2025.10.03.09.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:57:02 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:56:57 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joelagnelf@nvidia.com, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: android: Fix missing kernel-doc entries in binder.c
Message-ID: <aOAAWZ5DsnbqPxIA@google.com>
References: <20250925025517.815391-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925025517.815391-1-kriish.sharma2006@gmail.com>

On Thu, Sep 25, 2025 at 02:55:17AM +0000, Kriish Sharma wrote:
> Fix several kernel-doc warnings in `drivers/android/binder.c` caused by
> undocumented struct members and function parameters.
> 
> In particular, add missing documentation for the `@thread` parameter in
> binder_free_buf_locked().
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  drivers/android/binder.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 312b462e349d..d30d27bfc634 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2417,10 +2417,10 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
>  
>  /**
>   * struct binder_ptr_fixup - data to be fixed-up in target buffer
> - * @offset	offset in target buffer to fixup
> - * @skip_size	bytes to skip in copy (fixup will be written later)
> - * @fixup_data	data to write at fixup offset
> - * @node	list node
> + * @offset:	offset in target buffer to fixup
> + * @skip_size:	bytes to skip in copy (fixup will be written later)
> + * @fixup_data:	data to write at fixup offset
> + * @node:	list node
>   *
>   * This is used for the pointer fixup list (pf) which is created and consumed
>   * during binder_transaction() and is only accessed locally. No
> @@ -2437,10 +2437,10 @@ struct binder_ptr_fixup {
>  
>  /**
>   * struct binder_sg_copy - scatter-gather data to be copied
> - * @offset		offset in target buffer
> - * @sender_uaddr	user address in source buffer
> - * @length		bytes to copy
> - * @node		list node
> + * @offset:		offset in target buffer
> + * @sender_uaddr:	user address in source buffer
> + * @length:		bytes to copy
> + * @node:		list node
>   *
>   * This is used for the sg copy list (sgc) which is created and consumed
>   * during binder_transaction() and is only accessed locally. No
> @@ -3997,6 +3997,7 @@ binder_freeze_notification_done(struct binder_proc *proc,
>   * @proc:	binder proc that owns buffer
>   * @buffer:	buffer to be freed
>   * @is_failure:	failed to send transaction
> + * @thread: binder thread performing the buffer release

This is missing the alignment that other members have. Also, please keep
the same order of the arguments, so @thread should go after @proc.

>   *
>   * If buffer for an async transaction, enqueue the next async
>   * transaction from the node.
> -- 
> 2.34.1
> 

BTW, your subject is "docs: android:" which makes me think this is part
of Documentation/. Please just use "binder:" instead.

Thanks,
Carlos Llamas

