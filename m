Return-Path: <linux-kernel+bounces-880314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDFC256CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8990735171A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7C2459F8;
	Fri, 31 Oct 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XMaKKTCG"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05622A4D6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919522; cv=none; b=ScOwzr74cvfEC3+I7VN2Iab6AZPUoUDlrn7pkSW23tiqSBA3iBejXmYMzMMgA0Ypmry7hAOk1zXI7Mw0bjsJUiEB1z6BuCoZSS2VrOZnv2v5+mG1PMs7n1CjUPUdjPcJzJro7cVtt7s+f0bczPcPOlciQadxza8x4ezXJoRFyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919522; c=relaxed/simple;
	bh=ckWEHSYzRMCQdSdV1+aItXg+MoosM9PmpiIfZ+3IkXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDLRHEjafimp9HRdC2elgVs9SR1yFwNmAjTW4VcbCpsjx0BRGA7tAOMI3gniGJYut4S03iLjnVm6Mb0FsFfuQ/6WSIComak4VE+SyFTc8p/DhG+tiqqIU6/C6R7gseWcsvNfKAyf74GWZ0eK/5y7E2iYWbKWx8RN9KWsEawsmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XMaKKTCG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429bee84e7eso120174f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761919519; x=1762524319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEEYMKZKM55egNcS9TLQLwdFtLgzGx5oRqh6S7KgDlc=;
        b=XMaKKTCGw249u5j/ODNwFaWzk0Rn+JUnl1H8wZZfCxGIES6v6jHJ6kI1cVYJX4xMg0
         pLY3syWjlgbHEpuxqOzsqauChfcO+VB8IDPBuePVUEXBAR+FiTUej5E7eSaaaxw0Ly0H
         VOrQueaIYgH94O17gKdAFgZlJ9u8I+qmfb9qYpSiD1g3DdZGqvH9vKbOMLsaBLS4FHQD
         CSDP5Pzz8ebibfGc8toS7kFvFANKJV6OBY1h7459PQk9YvDyDE314W+2XB6XIdb1PB0u
         P7BMRQPUr4NQuQd2mnvGkydD8cigIa+Xv93OljA+hs1EIBh6/rNcOZzyNLXFCWZZHC3y
         lrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919519; x=1762524319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEEYMKZKM55egNcS9TLQLwdFtLgzGx5oRqh6S7KgDlc=;
        b=PvAtC9uYoPvKA7hfwo7zgSP1djhtpJyal7jlgQps0zPi7deGFWLk3Sm5f15J1Mio8/
         EEeUUAmz5e5PawvkxStPclrNCz4OV0022bFXom0oK0md1qVk1DkOCzTAr2EB4EIPF336
         4lC5WVMrgNF0OtotCvIQSLYcTrxMw6gjEhAhCD5glbrkbxKqVhZd0BMhpeLeQt4VHUyN
         l5DryEm4jpjw7mgU/3JNZIQIm2E1N1Ct4SidpMmHgrcqD5TAix3Y1WLLxXDNorucBUGd
         AKy46zJah7VnbmBchMnkjJNkyVat46rIQa/kJJulyuQ41izvv7P3U5WF3qbf8GkNgdvS
         k6QA==
X-Forwarded-Encrypted: i=1; AJvYcCUGkKo5QmFbtaA7ZqwrvEWRaqi+Nbp9BdyFL5AMyvDR8dm7SI+e0YjO8ivN7KJyYfXTcDZMKrhto6lRoOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYk7Si9GR2J/NSNnTIqy7FQjkC5keWaP6XnOR4P7TP4hDiNcGr
	3NLEcVwhcFmt5N1wycZa1JnY12IL6eetEW126btIjDN66LDSCIw2Rm+LOhu8KOfASEg=
X-Gm-Gg: ASbGncur2DnoF/OjsIbeqkF3//JjAWGKR616bppRn9zrovvR1+9hPdOUYgwCHr4n9yj
	6VhT58gTL7x7z6T7wYiXkVZ61UtFegbZTcFVNhlcst+8dsDQ6eGg1MuTqWe4imtptvEueeejVR2
	2wFcjfa45WC3CsCQREBDRxuQoZbxuS+jxqZDN5wYJGEPURv+oV4zCyP1w76L+EX3938Hgt3wYIm
	9vbBeF8gP7jDvK51cXvU83wPlVFmTlL2BxCoSzotWeEY/PaBeTobCVDNjHTQXko21CAGiu7HXqu
	Vl5trALIr9Pxhvj89phUQkw9oKLDqaYM7Vt3cjrtT8br23ickKdyzX/R38BUD0BFJmAbjDcmbmf
	S+X8BB3JbcTtr2O9c0wwGp0ERU2jmuZ1kCP1KyXvcjq8cEUYpzpz4OZjHfpx29y6uFTLD8cfBRl
	J3zBpeO/lExg==
X-Google-Smtp-Source: AGHT+IE20aFgYfEmUsR0QvaAoacDC6fODutHzSvHSUQsADrC6Dw8Qfg3mMEOFdiGJnzQSF6ImIcR9g==
X-Received: by 2002:a5d:5c89:0:b0:429:927e:f23 with SMTP id ffacd0b85a97d-429bd6a7a39mr1718841f8f.6.1761919518697;
        Fri, 31 Oct 2025 07:05:18 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269c1c17sm24932505ad.108.2025.10.31.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:05:18 -0700 (PDT)
Date: Fri, 31 Oct 2025 22:05:14 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, mark@fasheh.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, ocfs2-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, skhan@linuxfoundation.org, 
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <stmj7kbqis2idlscf5iwch23ft2azuyyr7q2kmelavjk5lnug4@66in667d6bym>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
 <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
 <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
 <aQQ0DLqL0iVN7D15@arch-box>
 <leys5guzkcvlilaccjmsw7cvncm6o2vqo2wwezhuz7r6lcfjnk@va3cnphl4zf3>
 <aQS_oUDXGt_nF__d@arch-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQS_oUDXGt_nF__d@arch-box>

On Fri, Oct 31, 2025 at 09:54:41AM -0400, Albin Babu Varghese wrote:
> Hi Heming,
> 
> > I support adding make_bad_inode() in ocfs2_read_inode_block_full().
> > ocfs2_read_locked_inode() calls ocfs2_read_inode_block[_full] to read the inode
> > from disk. However, ocfs2_read_inode_block[_full] have many callers, and in
> > current code, only ocfs2_read_locked_inode() marks the inode as bad. All others
> > forget to set the bad_inode.
> > 
> > The 'forbid' write operations when read-only mode is worth another patch, and
> > I plan to create this patch. This patch adds a similar ext4_emergency_state()
> > function for ocfs2.
> 
> We're working on this as part of the Linux Kernel Mentorship Program, and we'd
> love to take on implementing the read-only check if it's not overly
> complicated. We're just beginners, but we thought it would be a great learning
> experience to work on this following the ext4 pattern you mentioned - if you
> haven't already started working on it by the time you see this reply.

I haven't started the patch job, you are welcome to take it.

- Heming
> 
> > Therefore, your original patch looks good to me. I will provide my Reivewed-by
> > for it.
> 
> Thank you so much for your review and the Reviewed-by tag
> 
> Cheers,
> 	Albin

