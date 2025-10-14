Return-Path: <linux-kernel+bounces-851793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D049BD747B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D6B18A55E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC930BBB0;
	Tue, 14 Oct 2025 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fjg5Ts3r"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68730B534
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416915; cv=none; b=WYIL8bvTVxUQ9+pjIElsNoHMiPtY03dZu52nFOkpMOAH7vqHdATnnMpZhtVpHaDEs/T+yv9S4ETg/xMEm9HGYdRARjbUatzWkfWvCZH58/nYUKYa8MA4HRR6MEAVFqjh0pe+eo3E0HZjzxhs4vUxKqauMVosQceU823AvkmTJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416915; c=relaxed/simple;
	bh=HkIZGagwqQSK/Ux73E//1WE05pc2dBkZn1z8WlsOsmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1tLKeyw7AN3u9uiNyDr+5GqQMPmudMaPuSV+VhDZeQ+MW/OyW5io2VoACUw4Wbxd0yFR6R3su6uldPZz/mB/UP2h/fzQuyTiLZUfTjF5KA70GRr16L+IEKjQEya2/XLibPBaeMXAq/GjZos4Mf62VczZszAjbeilFHUGdPI4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fjg5Ts3r; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-58877f30cd4so15609e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760416911; x=1761021711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H993Yv05c5jEdeR6de+2fECvHc6eeWZhFT1JvbrSFk=;
        b=Fjg5Ts3rb495TT6Yz5OTQCOUFV2w1Lr4ec0+zT8Kv1m3K1n6tmGIo8yuSwaOq/B8GT
         R2sR3qTRX4dJFKiccoz75DpUlfX3eltiZUp7qYsUHKHazetX2H1i0UwpgSbM1y+Ra1pi
         dGnO4MDyMVzEkByd/f6iuZFdxWgMJ/f4AwRTeEIASbYLOEz5WYSaGxrh6KxENeV6YRtF
         mymSUb1GnjRntLiaO9L2/8JyQr6T5VU8sW9VHLagryK5TO41AQ8sQWlFsaQLKs6gXWdI
         m7XMicRMLoeYjwiwNcbIzrCH0JDmEnB6l14qItiOukeZpTUwKoTlBTNlxOP/btbAtT7P
         aDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416911; x=1761021711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H993Yv05c5jEdeR6de+2fECvHc6eeWZhFT1JvbrSFk=;
        b=OYA37IoU7DVTRO0tmSrLHuXO0smJkAtJ5wkPAT3JCk6Y0avwwUK1Epxuutz7J0Atep
         SSeFsyPlGHjQH8lahSpZE3oJg3b5rhZeimhgFqMS743kTy4Mn7sPBu9cG/WIyo/7BlsF
         MQhgMGgkl43EOljwINafLsiBdv/5OZHk0cUmg4pJZsOeIAXxYH9+xoSZPUMNonlouQWZ
         KI8Uz+98qmGoTxK14dPadg6CjsyKDoMrFwFKgreZ0FMbHFeVYXo1Z3Jou5dbH6FZ2kzq
         VuPzezY1DUfHc8a5FHw8ZIKRuAxwsMx8Pykod7pAL2setJkVisLMD2GDSYaov3/s/+Cs
         ihAA==
X-Forwarded-Encrypted: i=1; AJvYcCUFELTpxQBOUNhqOJDGB26L7HcEDQKtEF/ni0N31MX+WU8hmqLdZj8dtszBP/gPbtur65AI0fZs+Of8Ddw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NwIb6vSw9NgamdI5wlYoaNhZmJeR53Y6rWCfNwGgkkuF2wr2
	BiksXL87V5QeL0Mg9nPGwFkR6xl4r+0GCynQpc1sWQLyxLHYHfXDQMR6tQ5eUoM5F3bUPsz8ea9
	p+D9WRPc6oj27oCZqS6kSPU8TQARYSjQmWyVPz9Nm
X-Gm-Gg: ASbGnctV1OUbVR8Sr2yPU0QUXBZ1lcwLUFpHSnRkuedBDNFpKuGlq4K1TPwVgO3F/fp
	jWPyo7iyQiPGJqAix8bPz7mL4K57ohwdiZLW+71zKdSpLfwd9rWkxGZ0bMK8JkY1cjR+4bhn8qO
	HkiLjMOzUWF1wXR8w41rHgT2vx6q0Q36p4lti8cLTuw65fZqYoBWslmwoHTsF1ExJ7xnL3hFGnB
	va/xGx9cUspMyoBujEmqtcKinNnjApvKcanQjVp8APn
X-Google-Smtp-Source: AGHT+IGO2N6eEZzAYyKaq78kUeEFq20BCf9kSNKrULoXVn92wigmiiTTyiqOtJSWbFILRsrzS2mx9pVSEawVxWJPTh4=
X-Received: by 2002:a05:6512:6d3:b0:55b:9f89:928b with SMTP id
 2adb3069b0e04-5906e383503mr43296e87.1.1760416910537; Mon, 13 Oct 2025
 21:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760364551.git.asml.silence@gmail.com> <20251013105446.3efcb1b3@kernel.org>
In-Reply-To: <20251013105446.3efcb1b3@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 13 Oct 2025 21:41:38 -0700
X-Gm-Features: AS18NWDsUu_PMxJh1iCf-aXLBKzwTZ_46MmoA7_5elnWV_3Q5KDGegO5lPk6knY
Message-ID: <CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>, 
	Willem de Bruijn <willemb@google.com>, Breno Leitao <leitao@debian.org>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 13 Oct 2025 15:54:02 +0100 Pavel Begunkov wrote:
> > Jakub Kicinski (20):
> >   docs: ethtool: document that rx_buf_len must control payload lengths
> >   net: ethtool: report max value for rx-buf-len
> >   net: use zero value to restore rx_buf_len to default
> >   net: clarify the meaning of netdev_config members
> >   net: add rx_buf_len to netdev config
> >   eth: bnxt: read the page size from the adapter struct
> >   eth: bnxt: set page pool page order based on rx_page_size
> >   eth: bnxt: support setting size of agg buffers via ethtool
> >   net: move netdev_config manipulation to dedicated helpers
> >   net: reduce indent of struct netdev_queue_mgmt_ops members
> >   net: allocate per-queue config structs and pass them thru the queue
> >     API
> >   net: pass extack to netdev_rx_queue_restart()
> >   net: add queue config validation callback
> >   eth: bnxt: always set the queue mgmt ops
> >   eth: bnxt: store the rx buf size per queue
> >   eth: bnxt: adjust the fill level of agg queues with larger buffers
> >   netdev: add support for setting rx-buf-len per queue
> >   net: wipe the setting of deactived queues
> >   eth: bnxt: use queue op config validate
> >   eth: bnxt: support per queue configuration of rx-buf-len
>
> I'd like to rework these a little bit.
> On reflection I don't like the single size control.
> Please hold off.
>

FWIW when I last looked at this I didn't like that the size control
seemed to control the size of the allocations made from the pp, but
not the size actually posted to the NIC.

I.e. in the scenario where the driver fragments each pp buffer into 2,
and the user asks for 8K rx-buf-len, the size actually posted to the
NIC would have actually been 4K (8K / 2 for 2 fragments).

Not sure how much of a concern this really is. I thought it would be
great if somehow rx-buf-len controlled the buffer sizes actually
posted to the NIC, because that what ultimately matters, no (it ends
up being the size of the incoming frags)? Or does that not matter for
some reason I'm missing?

--=20
Thanks,
Mina

