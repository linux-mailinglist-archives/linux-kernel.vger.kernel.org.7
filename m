Return-Path: <linux-kernel+bounces-856631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF3BE4A74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D5619A60CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAFA32AACE;
	Thu, 16 Oct 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYlY+t/e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE22E62D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633001; cv=none; b=rjNj8rINTuEkz7Xtr4fxBrYSFUib+7zuqGByBJwkcWKL3yN4rXHRfnXcqx5MLdWULdlCeEjiJr1UUn98RlgV40tfLQsGw03Er1v7fcp0des15Fsg4iAy6m+eidBuBb2YkmQX5I5WYzlvhWW5ZV+miAXxzh5mq2mFev3/41nCRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633001; c=relaxed/simple;
	bh=hVQWi346CfFIRj57TmG7mDIKbGtDYBTuiV7lKs1NxxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz3NhLH7dOEVdyjOiKdcqBiPDXfBEGEFQ4lBUqVHSP9DqjRwQog2AsZWo8pVGnHWFR6uF6DaQaDdP4mhEPgtwvRIz9ZnNRaF+tKa6a1unF7D5yq+XsHf2C7h66EojfClunKt32rFFZZ4pXhDJydWg7eIat3hI1eCDqdeOruQ0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYlY+t/e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760632998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVQWi346CfFIRj57TmG7mDIKbGtDYBTuiV7lKs1NxxE=;
	b=gYlY+t/emEI6F5ODilabdWAsgO1P8UPlMwuz+kq381gFCMDRzvF9OZ4k8RjlEUhF1CZvXj
	vXkChRKyFpO95LoOJg4tJ3tIK8JoCXSOOrMzuLuHfiQWcT4Rs9MUou3WWC/BY2tm33GhDz
	yljiyimjVEYi2g+DF+zrY5jN5cRT7Ac=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-WeLiEAzwMmuhP5jGHHs8Fg-1; Thu, 16 Oct 2025 12:43:17 -0400
X-MC-Unique: WeLiEAzwMmuhP5jGHHs8Fg-1
X-Mimecast-MFC-AGG-ID: WeLiEAzwMmuhP5jGHHs8Fg_1760632997
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71e7181cddeso13895157b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632997; x=1761237797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVQWi346CfFIRj57TmG7mDIKbGtDYBTuiV7lKs1NxxE=;
        b=IZ76NYp5PrHNGoUufj/GwprQdMIviyJ2LBQUagozvHoAtATOCvT4plle7mEofXvSK3
         qcfOCmgui31dTICavEEPrgZQBJOmLHo8WInnklbPz2hID+m6f1HipaABF4WyHz0IJVUH
         3UfN0VRssqMFVjkKQjSfEhJ3l7bIDq9zTWkdHyvrSlFA5l88Yv+IZUGzUJdVS7FCbwOX
         g+sLYYg1pi28WyxX2CZaiZ18pqsfUf9su4urfgmwqhvuhbm8ih0QNcj5cV3TVzri9oSB
         D5Ah5AzSNrNVlU2p4nfXkCpdG3aOLGT884G0HWEwNRgfxHiswf6JmvJCgZ3hpAG0Q7gT
         tbqg==
X-Forwarded-Encrypted: i=1; AJvYcCXWClIyKQgB94hBh5pMGaoORDoURFKwBojts7fLntIKIbIM25l+ktrUs5dVVI7ywdhGGc/9CyVT63/jUrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWxXrFiiI2L8/qgX9tDbVVV/u5wyEDkOX4nJY5eKoJnHDWhdS
	xcfIDe2RSzVpbk0wTwTsAwXOeSYkYapQV5g0VZ6hK8z+CJFyIAJJIWkfAvKioyCz12Ie8UFU048
	R/nh0A60By5MBe5nLkfZ27yvUvKdWl3erkohpqnZNnOSOv5feAdX70p/5bwd9T3bwx0jdsCT8YZ
	CEkeWBYsNHPDUjOseJs/AG/Yr0kAA1zJNG/m0ZJ+XJ
X-Gm-Gg: ASbGnctWcNdVEKvVPDcJfeIYQNL0/8BdAhqZn4bh7LhHFNgPEEm1O9Engm29Ima3eFE
	TPhimG9h/xNe+QPTFMljJy8nj3PRv3Aw+W/YG2Qk5iN0gi6LEQwiisSMgAM/gyKPSTf85hYJxtm
	EAILE4zfingKkZQx3jQSzBbNY0B6KsJ6T7cMNMiw0aXycD2uZVqUuzww==
X-Received: by 2002:a53:c057:0:20b0:628:fd1c:c3d0 with SMTP id 956f58d0204a3-63e161391abmr659546d50.27.1760632996782;
        Thu, 16 Oct 2025 09:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mB3OeCFADl+jf2RSpEiGzKJOZy5msvHxNe0q5ZhXMEg1AZ+3Dae1uL8nRfkXcQoadqgSmyaXNBTPb9hTvMk=
X-Received: by 2002:a53:c057:0:20b0:628:fd1c:c3d0 with SMTP id
 956f58d0204a3-63e161391abmr659517d50.27.1760632996336; Thu, 16 Oct 2025
 09:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68ef030a.050a0220.91a22.022a.GAE@google.com> <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
In-Reply-To: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 16 Oct 2025 18:43:05 +0200
X-Gm-Features: AS18NWAlVrld73zUQk8uQm4oUFpr0k3NrXS-m7lewNfHMU6fVdnI_G8q45y50Vw
Message-ID: <CAHc6FU5Ay5HostiVPxyE_DuE-djScdV32B3iDrzsnX6e7-UWgQ@mail.gmail.com>
Subject: Re: [PATCH next] gfs2: Add sanity check for sd_jdesc
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 15, 2025 at 12:00=E2=80=AFPM Edward Adam Davis <eadavis@qq.com>=
 wrote:
> Asynchronous withdraw, when sd_withdraw_work is scheduled later than
> put_super, will set sd_jdesc to NULL when clearing all journal index
> information, triggering the syz report uaf.

that's not quite what's happening here; we are actually looking at a
failure in gfs2_fill_super() which calls init_inodes(UNDO) ->
init_journal(UNDO) -> gfs2_jindex_free() before flushing the
asynchronous withdraw work. A similar ordering issue exists in
gfs2_put_super() as well, though. I'll fix that in "gfs2: Asynchronous
withdraw" by moving the flush_work() calls into the proper place.

Thanks,
Andreas


