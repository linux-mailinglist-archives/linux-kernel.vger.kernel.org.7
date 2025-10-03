Return-Path: <linux-kernel+bounces-841639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D33BB7E08
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD70C4A356F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A282DC771;
	Fri,  3 Oct 2025 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzWhza7i"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA91BCA0E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515822; cv=none; b=BlpB9RLgpkJlrCTZFpOFko4lq+sbu2n1VBVfIBOlsxhKzHsyTtte42p9LNP3xsvxs9DIT8mCkjYAI0I0vGZPAdbVD/EkMFY1lBXETLC6SZSUiFt1MWMEw/DTuhCeUimHJ9iUf3igzfranPUbG6G9foSsmaRvB1pSDD0J63+R8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515822; c=relaxed/simple;
	bh=L20H+BYYoKrNV1pViBHrw/RLRnOLMd/7o+/XV8nsevI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm0a/VfqcdegY5wFlFFBjqI7VxqsQejL4ljhFKqbBJqyDuCPl1PBb40MUdyXRdmKi00O82AvZdJqmlnDinMuB6G/iDXm1vuWJ+nHsDIifS2w7Pvn5b1ENvpkGbtmRguuRzj9AyawOBPxUdKimE8ChK8DpyucVKbETFyUDJFk3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzWhza7i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d67abd215so29345ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759515819; x=1760120619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mY5KY1nZslNnsokKcb2YziJI8dJUMpseRaov2Ic2/P4=;
        b=vzWhza7iF5h9WDYrzslLKvwGFa7eBQ3OZM+/Iw0Kkgx1Pp97ApVj9w2J3ZTTo8EPVJ
         DSilfecs1k/0b8Naamr805fQ1XWcBz5tbTfDaQwirh35ikfN+qRH25VDbDuF5Ij/A6S5
         j0yFCsHMCf7I90hweWRj5yiGaNQ4Tzp1gGK68scpWCO0qq0yidVAtKusVmZB/F2QkopQ
         Kscq2lpWgxXskb8pqpeXiy3CUHRQC7Q3tiez4QKtv/uf3bw4hXVJnykYhna8szX0HoBD
         hH6sVHXClsw0wsNpRzWZ4YcNjiNl2I7H/L3Kr2Mv5dPx4RxnvJJpu0vm+1l97WcTVCTF
         6OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515819; x=1760120619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY5KY1nZslNnsokKcb2YziJI8dJUMpseRaov2Ic2/P4=;
        b=gVDx4o3oh2Xc574FLmx8h8DTc/GcRVijSGmTyAR3EDsGtNTj4WLJz7tAndpgOL/XGY
         5JY6UMGps4QYQquFbF3B225LUQBlTbAwdneGlMCm9J4P3VRRTKQjKYRKoJaft9W8MpfB
         NZkCYNZ3TptLjkOjLS4FJ6kPZCqkWu20PVeonXI0xRQmbLhYQYOpA+6qJHkuooQ2Za0F
         wPKMxLb/SBka+2o63hBGs6JtBqLw/NX0KzcA/nNZFMClAtujcVQjHuMyHArU8rCt8prC
         kWZzKm7kwacV4D4NRpysy9SJ2gWOaV2eV77UCFi23XfHJOi/XGl6MA7or4ex+FwwVwqu
         JNhw==
X-Forwarded-Encrypted: i=1; AJvYcCUAk+cfT7ZoWPn4FJqID/icdGr6FX6gKK0nNa96wAC86sHA48Q0RSeSQ0luCXlf69m8Brh3b//HrDYDY4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9jpe3XjKsR4sWHH15TAkpKdPWJJ5dQGHLSiNTr7+DobxQ7WL
	xH3xQVEW/IAMgJiILOWMeKEjtk9gmm8JWF19V99LkB/ipukn0f7KCQWWMeqg/CbUfw==
X-Gm-Gg: ASbGncsGuJfPoTCB8txXtY4fvKpyx01BgPhncrH1/IkzKibVx1E1r4E2N8w6ugmtiy+
	PRr1sI3ZZCHKwaaLQFgkuwPcUXE+0xvbSFmOrFyvfslH98/1EJK8/xou5bjJBv2LLFm3FSD+9oW
	/82ramR9fObkv/LCOjD+HiphD67YRvxhiUR03TkmAU7PaOHapH3DaqS41Ki6stHgJveMLIamJXi
	xL7lXwZQgbDoG4YcCafeioVxst3zz5smYKUmOftpALF1omuwB9spyuAErLhv42pH0DTrlgfWrat
	rAXYVZXDueCjky0fOFrrls34fQAya5ks/xTcVt5GgWBrE0LdXjWh4V6/gwT0+aPd5SOekrOMb34
	HkqfisfEUe//PD6qUjfpFZU5artbe8fCVAbpyaP/OQroWlZ9z9Y/ndXJlsAIYoRX6pAJi1aykED
	ltjuByIcbRHbqQuauvnEbEWHY78YrdsIqwk2XO8gVlxplTflRzESK540HbMUnYnkglliMVefs7I
	g==
X-Google-Smtp-Source: AGHT+IHpUPOoP2eXVPphMXLWkp04UC1VYNpVF27B3zJ+qLM/iMqr7ObUeCUFnJvX4pU7fjzxIBXDfQ==
X-Received: by 2002:a17:903:1ac3:b0:269:63ea:6d3f with SMTP id d9443c01a7336-28ea7f732e5mr414635ad.8.1759515818427;
        Fri, 03 Oct 2025 11:23:38 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074654sm5564873b3a.75.2025.10.03.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:23:37 -0700 (PDT)
Date: Fri, 3 Oct 2025 18:23:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joelagnelf@nvidia.com, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2] binder: Fix missing kernel-doc entries in binder.c
Message-ID: <aOAUovAmhN8QEAHd@google.com>
References: <20251003180849.1438872-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003180849.1438872-1-kriish.sharma2006@gmail.com>

On Fri, Oct 03, 2025 at 06:08:49PM +0000, Kriish Sharma wrote:
> Fix several kernel-doc warnings in `drivers/android/binder.c` caused by
> undocumented struct members and function parameters.
> 
> In particular, add missing documentation for the `@thread` parameter in
> binder_free_buf_locked().
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
> v2:
>   - Align `@thread` with other parameters
>   - Move `@thread` after `@proc`
>   - Update commit subject to "binder:"
> 
> v1: https://lore.kernel.org/all/20250925025517.815391-1-kriish.sharma2006@gmail.com/
> 
> 
>  drivers/android/binder.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 312b462e349d..d25b79a3d502 100644
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
> + * @offset:      offset in target buffer to fixup
> + * @skip_size:   bytes to skip in copy (fixup will be written later)
> + * @fixup_data:  data to write at fixup offset
> + * @node:        list node
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
> + * @offset:        offset in target buffer
> + * @sender_uaddr:  user address in source buffer
> + * @length:        bytes to copy
> + * @node:          list node
>   *
>   * This is used for the sg copy list (sgc) which is created and consumed
>   * during binder_transaction() and is only accessed locally. No
> @@ -3994,14 +3994,15 @@ binder_freeze_notification_done(struct binder_proc *proc,
>  
>  /**
>   * binder_free_buf() - free the specified buffer
> - * @proc:	binder proc that owns buffer
> - * @buffer:	buffer to be freed
> - * @is_failure:	failed to send transaction
> + * @proc:       binder proc that owns buffer
> + * @thread:     binder thread performing the buffer release
> + * @buffer:     buffer to be freed
> + * @is_failure: failed to send transaction
>   *
> - * If buffer for an async transaction, enqueue the next async
> + * If the buffer is for an async transaction, enqueue the next async
>   * transaction from the node.
>   *
> - * Cleanup buffer and free it.
> + * Cleanup the buffer and free it.
>   */
>  static void
>  binder_free_buf(struct binder_proc *proc,
> -- 
> 2.34.1
> 

Thanks,

Acked-by: Carlos Llamas <cmllamas@google.com>

