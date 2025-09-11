Return-Path: <linux-kernel+bounces-812468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2EEB53891
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EAD7BE5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D73570AC;
	Thu, 11 Sep 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NYIgODJO"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD534AB16
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606333; cv=none; b=ixn8gnafTJsdXORwXdH8NTpvJnHW0c0lzbAqWhSDPj81WIxPCUtcZfMvkNkieQO/Hi3hxIqwPB5F29LtnF30bEcKaR/Cm4E2A8E3cLVislDf32HlHvdfgnFhuxIMwog6cgklDv/YBfjSwU5IZODVTil1m3RszLcYV0257unJjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606333; c=relaxed/simple;
	bh=wPC0NzEbUYwHK+zb06lSL3AQGAOqYDRV/3EXFO4Nks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJgClSdayHTS8/DJwL68ckn548JryOf2IAKes5Zu+3jEQauRDZ+gsANaFSfLdWMehjtwlJSHVtc+p5vwQDnAzv6XQ0NyuoAe8fv+43H+QedMNr2q5ZFFtdnduS/zQ6ONN1M0njlhQVWdr91VmchY5zQy7AzZh6v6L3Y4hI9t7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NYIgODJO; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b04679375f6so159040566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757606329; x=1758211129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIfzDPD+0iCfMAI+hOlLXocBqarNu7N4q+BtLAB+aak=;
        b=NYIgODJO+0K4pMREZmU9CfwIXwfCEHiBmjpa4lIso5JylqJ1lDizhFTAsjciXwKMs3
         zB4kNKkaVbnC0htxXwz2vWg722rYQWp2LWa5t3/s6jZpNsLr3nlkPoCKc6Q80tVa7Vor
         +2XB4u+Z2u310bJPvRDRnwMIkUmhidq8KvJoYqZqGIVZZf6rvux4fHIhrZPK0c81s2LR
         a5VFd2rQTUvl50CWNMGc72XSBz4wJF2LjV+tczl0Z2XNIluMeay7uk2i86RebYU4NDXe
         +OoxG+Q2JY0BMQhm7xUVQJ7u6qXbZ3QoyUuoq3pIe/2InYdGIOyZkfKNp31U/JX/NM/D
         bRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606329; x=1758211129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIfzDPD+0iCfMAI+hOlLXocBqarNu7N4q+BtLAB+aak=;
        b=fgnt3U2bwFQe5d2qzzemApK7K5pvCsz9EwjMEikvE4B/8hngU/yFOfjJ81WQ3/8+Z8
         qUIDpglfYXkeXxIbVKYPbl1vF3vslX794WqEUeRFOc16l28MEEAyr0kA1xDiSApMR0Cm
         Ngoe/0xto2Bpd/SWzFDyji91ExugQuOX74ukwixiTj5mXbou/OlGLro01dfwnOwXXO/r
         B95ghyjQ+nmyC6Bjc8UFtbVZ0hwtxF/5WLa/jpd+gkV8Hu+acPbs5akR1PKaFbVXoJTx
         C3tkQY1KyREk4qphz3xTrjPuinW6nZIDhXwmOjiQcXHzwBsR5AUTleeo/ZX0SKryt2W4
         qBnA==
X-Gm-Message-State: AOJu0Yw3Ygkds1/JsVudjt+Ixjm0dNOvTSRaRmfFm43bIRR661S6PJu8
	pL5FJQd5nRMVq0fOR6vcMIkCJrXPIpz2y/8eSwErTfnaJ+oek6Et7I6aLTJKKiplHko=
X-Gm-Gg: ASbGncvTUI1gOtdOwi1KtKPYS5VK39TkaRBgWXOFeMM9W+3vd9q5QK1gzItc1C1+uTI
	ASDZKP/O9tjABkQYzJ/7GGcdyyxty2c+ETyv284JmhCgH0JOSpUnYhgPNf1Fg5ZCcPBmnklwjho
	svrfz19xavWSIAv9+qL6QeL+SOtmOME5Jau9drr9XsiFxaglt5TkDsmXtnI64/+f8nf2tka6T2D
	9a0f5A8IwaPD43yuPtXxFhHR0BOqDiodUD+AoxxHgW3gCLCj8WnVfnh3X21BfRMLydwffxQ9v69
	nEZLVfDNpwSL9ivWHeHqVWTJgy/NipXl+fG6gyg+7okoO7w/okJxE++nHLIWBHOOgixlI6zNhn5
	2eH02fLuX/BX3AAxoBtGI6adw9SmC2G35gTJg
X-Google-Smtp-Source: AGHT+IH/obCH1+sfMe3m9FRRAmk+JKX40flfSjRGjDmRtH1gLG0RmPqeopK1ra1OB+gyA/3rhUywzg==
X-Received: by 2002:a17:907:3dab:b0:b04:2ee1:8e2 with SMTP id a640c23a62f3a-b04b154715amr2008382566b.36.1757606329359;
        Thu, 11 Sep 2025 08:58:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm158238666b.67.2025.09.11.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:58:49 -0700 (PDT)
Date: Thu, 11 Sep 2025 17:58:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMLrGCQSyC8odlFZ@pathway.suse.cz>

On Thu 2025-09-11 17:30:36, Petr Mladek wrote:
> On Fri 2025-09-05 17:41:50, Daniil Tatianin wrote:
> > This series fixes the issue where data blocks would wrap in cases where the last
> > data block perfectly fits the ring. This caused whatever was at the beginning of
> > the ring to get discarded in this case, and the data block would get put there
> > even though it could be put at the end of the data ring just fine without
> > discarding anything.
> > 
> > Fixing this issue also allows to simplify the check in data_check_size,
> > previously it would ensure there's space for a trailing id, which we
> > don't need anymore.
> > 
> > v0->v1:
> > - Fix severely broken code alignment
> > 
> > v1->v2:
> > - Rename & invert get_next_lpos -> is_blk_wrapped
> > - Add a new commit for changing the logic in data_check_size
> 
> The patchset looks good to me. But I wanted to do some tests
> and it failed. I did the following:
> 
> 1. Applied this patchset on top of printk/linux.git, branch for-next,
>    https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=for-next
> 
>    I this branch because it contains a new KUnit test for the printk
>    ring buffer.

I forgot the add the patch:

diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index 2282348e869a..241f7ef49ac6 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -56,7 +56,7 @@ struct prbtest_rbdata {
 	char text[] __counted_by(size);
 };
 
-#define MAX_RBDATA_TEXT_SIZE 0x80
+#define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))
 #define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE)
 
 struct prbtest_data {
@@ -251,7 +251,7 @@ static inline void prbtest_prb_reinit(struct printk_ringbuffer *rb)
 static void test_readerwriter(struct kunit *test)
 {
 	/* Equivalent to CONFIG_LOG_BUF_SHIFT=13 */
-	DEFINE_PRINTKRB(test_rb, 8, 5);
+	DEFINE_PRINTKRB(test_rb, 4, 4);
 
 	struct prbtest_thread_data *thread_data;
 	struct prbtest_data *test_data;
-- 
2.51.0

Best Regards,
Petr

