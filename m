Return-Path: <linux-kernel+bounces-812487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3EB538CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9BAAA67B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2DC352098;
	Thu, 11 Sep 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BdvCfNuD"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CE352FE9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607107; cv=none; b=Ol6UAn6HLxf2kCFF/BX7Rm+oPqOqXRclVMSiIGjXhg+UXkq5dGaSxZn2Pxe08hbw7PYSEqADK5ZzkArIbTzIpiXk+WFkZUplnHEzNhIo3YWSB7hq+1dRMdNvYRaLG/Pot2GtbnjdVM3Z3xciRCZRloL8rqaL09WLwc23mpXMwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607107; c=relaxed/simple;
	bh=Hz4ibDbXy3oSkMATN5ck0Ue4n/4+DATfwiAS/EBrIlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVcoG06pxYhkGvwMfmtFqHm7c7Wed6WLxlsnfFZFIN+9mIgNV7QDACQ1up2F+B4DwBhSSXqi6ZoukLKmS+/1FFHIhCBEMpCDj8Aiax2bC0OQmzFX4J9b2C0mYTdNUoDM9wiV0XlZeDUXWLu+kxfEj1wr0ccqf3gTPwUE7N/0oQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BdvCfNuD; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso1660971a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757607104; x=1758211904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEStAHennGttpoKy0vJmMnsve5dMaGyKXsJ0bKD7Eek=;
        b=BdvCfNuDFSLEvSwUWf2+812wrDvaIepYBlcF9LZAxrOpDdv4uzM2D62SndVGvJ6EtA
         gliOSJmPurg3G3ScXpCacVEPyUVUmcMuPMMr7a+rr34ZnHdjFprUb/+jSW96+o/pc5cG
         uEYyzUZiSX4z+TPbAN2Hw7Rks1DVZkDtn/sOjV43MZgwrMK3FWighwB109SICbj4yROe
         eJ5WyVPnDFewrTcmzJce55uRu6peXtLO4jYSFhddhZ24okIR3QO6o8LvTWZdq9XwUhE4
         JxzlO1nevU0a5wcKxIwbYyFhTuJctueJmuK5mZjTVsqweCTle/rimyto62TK22drTgFh
         /aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607104; x=1758211904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEStAHennGttpoKy0vJmMnsve5dMaGyKXsJ0bKD7Eek=;
        b=Q+VVbcPNEX1phw865kVPShw4wMRqnl7ebpeOlP/U1ZlcPO0CADgO5wrLEU18fKgmTd
         oK4M5z9ubDputOGElj9+o/cZ3Sh7+XfAENtJ7p3m3LRr5gVTH/pA5IpOqiQhL0NwM//o
         LwzO/wp5/ovgEafyAv0FzQlIfT4gtzyWhk+CXW9UT5NJovisiph+KSmvlGm9fAY/AcaP
         87jRVy5Dv5IK2xJ6vq3TQWtk2iQOX2cU2+CkspF7TF/veI7SiW8wtVUohRPp57sb7wMv
         PuHTp7R8ipYoielT2ZJ6cIu4xOqx1A7oGiZiP6vgKABgcekyZBYlDSSgwzuUINIdh9tF
         o4cg==
X-Gm-Message-State: AOJu0Yxs8//LBsha5pkctdcqMKCt51AeIwkAy9n9JEuA4LmrHA8RYYtn
	nxkR/+WK16Na/JK/P2T/eOAsBMi+7GoHGCEchGn+M38CQy9TAg2AST/iT/PYHguQhX0=
X-Gm-Gg: ASbGncvwe5gIuIJV+mtVlk0N7JJUA8j1d+XKytIMjTxpsYBzndhzRoD/GlGrhrarsTB
	cYXtM9AFnDmpc3dI1JLveNAvfCRgrKWok69Ia9xsZ+0zVvYPhGtDiaDIvOrRQo3nn/zYxjutQZL
	IVd/JhMk2I8CgVBPjzPdwP8NXd5CBmgPzV+/WsoU72N2MeYV0ws9ncZ3FV2Ed8Vgwy8U4Fi5BZ8
	AMc9Y8OV7iMVIP9y5it13IeIrSr1+HU7fDoNTiF5Ojos2RMiOnO3rk1rF+i7r11nY6HJUAkn4aj
	JuZRxhE0lBEeCH63X3M7KHgDGqGTmoN8mzWXNkZv2iWX90iezTInTGen2kLu+gz4Z8nsf9R0GX9
	FhBYJp3a5/p1MbZg4eYLOHjeivHthU6Njm5HV
X-Google-Smtp-Source: AGHT+IGwOZ8rDeRRUgvvmNaUMC90K62nJ7jP5WFgiHmT2GpR28iBgt/Ei2xiEXuPTlYblbz26NrJ3w==
X-Received: by 2002:a17:907:3c8c:b0:b04:59c4:d90 with SMTP id a640c23a62f3a-b04b16dec24mr1939300466b.46.1757607102761;
        Thu, 11 Sep 2025 09:11:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da454sm162677466b.3.2025.09.11.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:11:42 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:11:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aML0vKgiXQSh-j2_@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
 <aMLxAlUgXpSs-tVN@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMLxAlUgXpSs-tVN@pathway.suse.cz>

On Thu 2025-09-11 17:55:49, Petr Mladek wrote:
> On Thu 2025-09-11 17:30:36, Petr Mladek wrote:
> > On Fri 2025-09-05 17:41:50, Daniil Tatianin wrote:
> > > This series fixes the issue where data blocks would wrap in cases where the last
> > > data block perfectly fits the ring. This caused whatever was at the beginning of
> > > the ring to get discarded in this case, and the data block would get put there
> > > even though it could be put at the end of the data ring just fine without
> > > discarding anything.
> > > 
> > > Fixing this issue also allows to simplify the check in data_check_size,
> > > previously it would ensure there's space for a trailing id, which we
> > > don't need anymore.
> > > 
> > > v0->v1:
> > > - Fix severely broken code alignment
> > > 
> > > v1->v2:
> > > - Rename & invert get_next_lpos -> is_blk_wrapped
> > > - Add a new commit for changing the logic in data_check_size
> > 
> > The patchset looks good to me. But I wanted to do some tests
> > and it failed. I did the following:
> > 
> > 1. Applied this patchset on top of printk/linux.git, branch for-next,
> >    https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=for-next
> > 
> >    I this branch because it contains a new KUnit test for the printk
> >    ring buffer.
> 
> The KUnit test fails even without this patchset, see below.
> 
> > 2. I applied the following patch:
> > 
> >        + It reduces the size of the data ring. If I count it correctly
> > 	 it should be 256 (2 << 8).
> > 
> >        + It increases the maximal size of the text so that the maximal
> > 	 record size is 256.
> > 
> > 3. I built it with Kasan enabled:
> > 
> > 	$> grep KASAN .config
> > 	CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> > 	CONFIG_HAVE_ARCH_KASAN=y
> > 	CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> > 	CONFIG_CC_HAS_KASAN_GENERIC=y
> > 	CONFIG_CC_HAS_KASAN_SW_TAGS=y
> > 	CONFIG_KASAN=y
> > 	CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> > 	CONFIG_KASAN_GENERIC=y
> > 	# CONFIG_KASAN_OUTLINE is not set
> > 	CONFIG_KASAN_INLINE=y
> > 	CONFIG_KASAN_STACK=y
> > 	CONFIG_KASAN_VMALLOC=y
> > 	# CONFIG_KASAN_KUNIT_TEST is not set
> > 	# CONFIG_KASAN_EXTRA_INFO is not set
> > 
> > 
> > 4. I loaded the test module:
> > 
> > 	# depmod
> > 	# modprobe printk_ringbuffer_kunit_test
> > 
> > I am not sure if it is caused by this patchset or
> 
> Hmm, the KUnit test fails even after reverting this patchset.

I do not longer [*] see the problem with the following change in the
original code:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index bc811de18316..ff93c4a079f7 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -409,7 +409,7 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 	 * at least the ID of the next block.
 	 */
 	size = to_blk_size(size);
-	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
+	if (size > (DATA_SIZE(data_ring) / 4))
 		return false;
 
 	return true;

[*] I did 10 runs on the Knuit test. The problem was always
    reproducible before.

I hope that the race happens only when one record uses more than
half of the data ring. Or something like this. So that printk()
could not meet it in practice.

Sigh.

Best Regards,
Petr

