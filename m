Return-Path: <linux-kernel+bounces-782425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64563B32039
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BAB1C81B66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D7267F58;
	Fri, 22 Aug 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="In8n0jpJ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D625B1DC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878724; cv=none; b=d3CcmaK6Bb9HYYknA8BJaFF8DWuYRTxzLqmTONvR3QJZzeRUhBUGyAyYTZDl3Rkv7bea2wvK+k8CF4H3hwH4iWriDr7nTJIaX5qfZhNmcO3Jfd8mxJ92hRWvwJVQ5vIVhdxAs/9U0eRMDnnxRtNBLO4kE7eRJBmLpVR8h3u++eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878724; c=relaxed/simple;
	bh=4HGGhjzaXgljPlrVoiWkH/usNNNrz/eCJBhuP08RQBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjZef33XlJKp6jtsBwgBrev9wuTr01LAqVvTujCypHKBgGWrMAKjkmPp9HSL9jmxb+JGTiMWdS4vKAU4qPPJ2DYvIFT5Tv785MDHWNK78fPxKMKx4UtglGx/tlcCf2EbLTOCEQ7DH/ObXg40R02HsCBQEGgzluZZOsEp/UtF1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=In8n0jpJ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e933a69651dso2112477276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1755878722; x=1756483522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9ay14s/9V/qQ+ANLBTM1wZMlblZsd2ot35thfa768U=;
        b=In8n0jpJeZw3IerTldJywqjCxyAgysO/HvdzNYUGcsnZ795H5g3mDLMMoD/kTwuYJv
         dNL8V6j7rxcSnlJZ/63LIEb3DMZ+81gcExDdShyDWF2lIBXVY2FYwNPDzMgvZp/Gs/pG
         Wue/PC+eNHjHv8Bki+x5CeO/JcmTzUd/JMTM+KMvgLCoKx8tOVo8UnPCDP1qw4ZXGgWK
         q7KstIYDlmKdToeb62tgrlyH557Em1lxgZrXQbsaQtHcV5aQlFlJi6gk2finmJCeOUcE
         qnM9GRV46pk6C5jqcfoEuqlwpCe/ItXrfzPT8znv2xjsmpRQJ5iHO8V90dWmEFqopjaK
         /cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878722; x=1756483522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9ay14s/9V/qQ+ANLBTM1wZMlblZsd2ot35thfa768U=;
        b=f5WjCbjQMFY4cnK3u22kqtF3iYchDzsSfdaiuatuOvje78ufYJlpPuO4PyvBnNFT6i
         hT/zJpqqyKHDiMqsdQqY3Kw3jamZLujhTXiOSyDB+DM+9iSBw6dZj5itoW4BcfUWd05L
         pFeN7W6h5Lk7kptME4uq0Q+gMAIq55ErLNFgpM/n/ZOOIS2ylbLB04kGiZYtdSUcM1WF
         7HkMcthcRhd06zUayDNFOj/AzjRo94nWPJSmIPzXq1lqHOrPKSk1atE8RWmjCNpsb7FE
         ohTD5cYbQ4p7jAlxmUOm25/4l4dCO5hMWLs2J1gJLlXp8XF3bwD/k4cKNCIAUCHkahKb
         nNJg==
X-Forwarded-Encrypted: i=1; AJvYcCUrbnRT6/oGpk3buQpSXV5RDzv+AMwENDYTbx4vNhLBgLe5CajihnY8+KNL2nBPQaUff671Ou4LklT0z5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2U60r/iMeLn7JFaaEcdffSebgKPWuUxsYyRT+IvU8s9Y71HjV
	IQ87wryaE3wfvIAooLiknxmsrYSAwUBf40r0ZTYkyzPEURUvOuddvR17HNUpYvO6/U+nxriLy9A
	1WZ+ZsP1hj40qDCu8Rq1Tao9pGtqrY3qgpgOOm2fG
X-Gm-Gg: ASbGnctTHWiAcKA9B53fd+JFtoNIkPEkWFI5hOsQePtMCUPFxrhrwjXsZ+Y/ypEYGgl
	oH3E+bVNqGa1isrzlUGUAY/sci2j779kUjaAYkFKULUzBTUPor8fcEH1fKLFwF5zTSspSqRSSKS
	QJppmTpdBw4oQYIfjkVlTFa3SBXlnRv+eb/izayxTRGdHuu4i3gpSfjj34p14YAJXnRF1VO2OYb
	z1lXiGAcCaeGYzk
X-Google-Smtp-Source: AGHT+IHgFTGiiSlutHh4BL3I8depbE5xMZ+e6c8q12fxs01ieSpD8QPNtz+yDLXoQoUT5WYYo25pHgJxdtdfDhYXg48=
X-Received: by 2002:a05:6902:6b11:b0:e94:dac7:25a1 with SMTP id
 3f1490d57ef6-e951c3d6404mr4039931276.37.1755878721193; Fri, 22 Aug 2025
 09:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
 <e11fd419-1095-471e-a57f-fc5ff7ce713a@ti.com>
In-Reply-To: <e11fd419-1095-471e-a57f-fc5ff7ce713a@ti.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Fri, 22 Aug 2025 12:05:08 -0400
X-Gm-Features: Ac12FXzPWOvD617AZlYm2nxRItTWDQkM1o-McCwfQKhcE5NzzuigmYKXVsFHZVI
Message-ID: <CADL8D3aR_ecr4q54cX7yfr_aDPA7NhXmLhkiHjUY9MjNZeg78Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] PATCH: firmware: ti_sci: Add trace events to TI SCI
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 4:04=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> On 8/20/25 1:10 PM, Jonathan Cormier wrote:
> > Add trace events to help debug and measure the speed of the
> > communication channel.
> >
> > Add parsing of the messages types but I am not sure how to parse the
> > flags, since the REQ and RESP flags conflict. Left as seperate commit t=
o
>
> The REQ and RESP flags should be handled by different TRACE_EVENTs. Right
> now you only dump the content of the response messages (the ones in
> rx_callback), also tracing what is sent is just as important, so you
> might want to add slightly different ti_sci_msg_dump EVENT for the
> sending side which uses the different REQ flag parser.


Does it make sense to have seperate trace events, one that only decode
the hdrs and ones that also include the buffers?

I'm bothered by the code duplication, but am trying to convince myself
it doesn't matter.

Currently, with the above updates, if you enabled all the traces,
you'd see something like:

[15.579036] ti_sci_xfer_begin: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000402 status=3D0
[15.xxxxxxx] ti_sci_tx_msg_dump: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000402 data=3D<data>
[15.587595] ti_sci_rx_callback: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000002 status=3D0
[15.xxxxxxx] ti_sci_rx_msg_dump: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000002 data=3D<data>
[15.606135] ti_sci_xfer_end: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000002 status=3D0

Presumably if you were worried about timing, you'd disable the
msg_dumps, avoiding the extra memcpy's.  And if you only cared about
the data being sent, you'd only enable the msg_dumps.  Does this make
sense / is it worth the extra trace calls?

Or removing the buffer decoding in the msg_dumps, removes the duplication:

[15.579036] ti_sci_xfer_begin: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000402 status=3D0
[15.xxxxxxx] ti_sci_msg_dump: data=3D<data>
[15.587595] ti_sci_rx_callback: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000002 status=3D0
[15.xxxxxxx] ti_sci_msg_dump: data=3D<data>
[15.606135] ti_sci_xfer_end: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000002 status=3D0

Or do condense the trace calls so they all have the data into something lik=
e:

[15.579036] ti_sci_xfer_begin: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000402 status=3D0  data=3D<data>
[15.587595] ti_sci_rx_callback: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000002 status=3D0 data=3D<data>
[15.606135] ti_sci_xfer_end: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
flags=3D00000002 status=3D0

Simplifying the code in the trace header.
>
>
> Andrew
>
> > make it easier to drop or make changes depending on comments.  The two
> > commits should squash easily.
> >
> > Nishanth Menon and Vignesh Raghavendra requested I send this patch
> > upstream.
> >
> > Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> > ---
> > Jonathan Cormier (2):
> >        firmware: ti_sci: Add trace events
> >        firmware: ti_sci: trace: Decode message types
> >
> >   MAINTAINERS                     |   1 +
> >   drivers/firmware/Makefile       |   3 +
> >   drivers/firmware/ti_sci.c       |  11 +++
> >   drivers/firmware/ti_sci_trace.h | 146 +++++++++++++++++++++++++++++++=
+++++++++
> >   4 files changed, 161 insertions(+)
> > ---
> > base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> > change-id: 20250709-linux_master_ti_sci_trace-91fd2af65dca
> >
> > Best regards,
>


--=20
Jonathan Cormier
Senior Software Engineer

Voice:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

