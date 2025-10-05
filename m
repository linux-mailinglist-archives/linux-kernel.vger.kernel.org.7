Return-Path: <linux-kernel+bounces-842508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B04BBCE0C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C944347C35
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382B22FE18;
	Sun,  5 Oct 2025 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecSn6Kes"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41A39ACF
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707304; cv=none; b=N4QTGBu3kTfCIbFY9aZzT40Cbp1Gf1mzzEPk8X94OZ2Wg4luBwOrLenPJl4qCr19V3NvhoGDSkJ7G9izjJM7E6kz7dkfl5i/Uq4gJATyzKgQsO2+BmgY12VR/bRvGvAdGq9iY8IttmFtHk7879FM9k074FqX65rRBjO4iy5jix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707304; c=relaxed/simple;
	bh=xotqYMZ9YU+BENzKLK/pOhIYZLLAFb3btLyE5+SSasE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I43wpiv2P4DTnbTCagTaSGExJpzUwURFTbWSKxoO1b5HOVbVfAO8nJ7Srxcbt1uz7EQRC17+8La/I06DWfzyxc3IUhjSPm4QQgQ7mDPK0oj8mbnRFI4qqJiTsQXvkjcYFoxQ0HjXDMZznm8UOC/s6h09vQ9mAaMpybS36Q+Gr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecSn6Kes; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-35ba7c71bfdso2323608fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759707302; x=1760312102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhShwqm3gQjPZCNm6kW8lvYi/GZrLquVLhihvLMlVd0=;
        b=ecSn6KeseTrlyh5GyU5g50WqJ0S4/KrTpup3frDgO9iFoTX05SaojjQb2H2p5lP58F
         tXjdrkO2kXy0CvDIHWM4+4/pbmuxkLlvaf/P6IEgeLgL4vuB5Qe8iJHr7LFPk05qvYjk
         Ebt1VaXycGCoA3Hx85m0wZ4CoslgecLtnLzzXqqjKu6owCBosXYCXpFr1NZt8nwsd16A
         PMIR4hdFF2xgTAg8nwQtDW6jWeCsu5YXTdw3mZzflrYUqXOLqHV6QaKLFKB0T+jw5DI9
         qjtLXJTDJnNmFftRXeh8ECY/3qUmZdln40a7sSGfSFMuyFBhRfjan9+wNrRbWMaSvvrs
         Ovfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707302; x=1760312102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhShwqm3gQjPZCNm6kW8lvYi/GZrLquVLhihvLMlVd0=;
        b=jRVt5e54/F0Dotl6CIcxHqd+4d5Rty5MFIZ6baVnnIXfib6pEnSpUzKw0mE2daIx0z
         pqCJtQwY2sZ93B2Cfl0kgfxsQwCPvfJtbDswY59inB4kZWnUM925u94Y5YHDq4sEN6fe
         eYjeN7xhqX/Ww7k89F7rZh2om3OWAWOoR9BYfV6+tOQxuylgRhc0p1kgGJv0u07KjU+j
         emrXJHHOnqksgioC+HYOxx/dsP/bNI8wC+oszonbfXTZKzZCxJhz+S8Owge6PxHYMr6W
         hRENhkuFHJbC4qbWvBGa0UuqGxZQdIkR6QmvXYirmRHG5HuBSVHbPm27tLD26aTgDva0
         s57A==
X-Forwarded-Encrypted: i=1; AJvYcCV04v62P6Kxf3Exnr1RV8ExK4p22lmol19DLLQCYxLoAzeJAXgCNoQZ9fpCGyJK8+agCoXXTxMqnpkOTQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAD4eOFVPnMHFTPoovG5V1nELGlfC4/rIBB4INezevpz2Ll9S
	o/g0D6tCWldObcMblx90UG6AhhT6jAPme5uBtG+2qu87j6UctY389QAUqfeHQyiuC7KQZdGIbwp
	bBZl1H7+fePsWCXBgmCXI8G5KTcL2Rzo=
X-Gm-Gg: ASbGncu7zpAMOetEWvESAfmLQy3UD+vhzGI6q70kT44NMwpfDXeUE4AioRTZ3dp8/Ot
	Ft8o5udLbnIvmcYYBC8Rl49CyHjgi8JlBOIKaIrxGqjddR6Y8m65XiWDXDu3ZJ0+OFd2+cIJntx
	ITk6AdoYdKRbUI9FdTzMBkkgJSiJXs85AyaTlp1xALqY1f9pOA1ogIc/eU65Osyget09tBLRe1Q
	bREB+2zNDEIECBJWMjP2Ebc9RjPJPga
X-Google-Smtp-Source: AGHT+IHNBEUFJrzq7L+vyOQnFIA/X6Ux7K/Ubqa/yHibi5O0wEDjYIV/UxBlQ3Ph6gNT9/IRlo4z4Kw4f4yFvUQoZ90=
X-Received: by 2002:a05:6871:522a:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-3b1019a23c2mr6009274fac.25.1759707302293; Sun, 05 Oct 2025
 16:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com> <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
In-Reply-To: <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 5 Oct 2025 18:34:51 -0500
X-Gm-Features: AS18NWAFTrUrjHeUPhL2GLVdXXxvEsjDWhS5snu-HQnkYOkoSt4zyImcUMAWSss
Message-ID: <CABb+yY3T6LdPoGysNAyNr_EgCAcq2Vxz3V1ReDgF_fGYcqRrbw@mail.gmail.com>
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Matt Johnston <matt@codeconstruct.com.au>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 12:13=E2=80=AFAM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
> Jassi, this one needs your attention specifically.
>
> Do you have an issue with adding this callback?  I think it will add an
> important ability to the receive path for the mailbox API: letting the
> client driver specify how to allocate the memory that the message is
> coming in.  For general purpose mechanisms like PCC, this is essential:
> the mailbox cannot know all of the different formats that the drivers
> are going to require.  For example, the same system might have MPAM
> (Memory Protection) and MCTP (Network Protocol) driven by the same PCC
> Mailbox.
>
Looking at the existing code, I am not even sure if rx_alloc() is needed at=
 all.

Let me explain...
1) write_response, via rx_alloc, is basically asking the client to
allocate a buffer of length parsed from the pcc header in shmem.
2) write_response is called from isr and even before the
mbox_chan_received_data() call.

Why can't you get rid of write_response() and simply call
    mbox_chan_received_data(chan, pchan->chan.shmem)
for the client to allocate and memcpy_fromio itself?
Ideally, the client should have the buffer pre-allocated and only have
to copy the data into it, but even if not it will still not be worse
than what you currently have.

-jassi

