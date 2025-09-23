Return-Path: <linux-kernel+bounces-829416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE286B970AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8871896F05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DB27FD51;
	Tue, 23 Sep 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsCZajrd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E22765E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648899; cv=none; b=UvD7RSGr4g7l6dNx1m/Hk/5U3bqmahXpITEvvPsra5fYOZ7iHCBUheIZela5A6ymP7ha0uNt9MlIPK9Y3FUmcw2JokmBvVNumtuBSRd3OgQXHiP7eUflxOrWo8tVYEK6Y5e5wzH/vfrahg/HMaqGOAqdATbKQByGDBHf49srR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648899; c=relaxed/simple;
	bh=kiHYOV5tKHdiZHaewEhed9KwrpNMOwErNX95ewTe0bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po8Bp8VmSoGvCo3PiHkeRgPkQShBCSlPgoIZy2/qwrOaRPXUZOxSDmgEt0g7k+Trc/seDXjzZLlAWpMUaav3sdJdfiZ1HUYosNZ2K6zFjiuHiE9EAJk8xIR6Is7zSVBP4W5r4hFGISo7Dix6z7mc+lI/mCNiIhqQmCIoRLfncos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsCZajrd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758648897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeHg931zRHI47gvkNWZ7vE3F3NuZSRm6Ea8fb1/M8s0=;
	b=OsCZajrdvTWVOr9xcfb+DaOocHqY2wMyO5/FP5mqhofGmMhmXf1uFzAFNQDzVilAyto0yD
	WzG8WIKcdZsonEwId365b6FYtLl41O9j0Gh15PM5w+y8Whxci6yEnAeOqUZ3LA+vQZCPT6
	l1qqpR4gKZJqfacp5lfDMSGHYRN0moI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-BOEUQwuAMKukL-2IpGDofQ-1; Tue, 23 Sep 2025 13:34:56 -0400
X-MC-Unique: BOEUQwuAMKukL-2IpGDofQ-1
X-Mimecast-MFC-AGG-ID: BOEUQwuAMKukL-2IpGDofQ_1758648895
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b04a302fb7cso528118366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648894; x=1759253694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeHg931zRHI47gvkNWZ7vE3F3NuZSRm6Ea8fb1/M8s0=;
        b=Z0r9sDmye6MNkGfPgTIpRVZtfQBmlileijQhvaQj00uV3bGpzTwn9qbmaqSbMbctiR
         8KcxuX2b1XEu1KWqZ1qrq9Ihud8puwIQ13F7RI12BoBd9DvFfLqIqO4wlZhyJVCvfi1M
         6YtDbolBwRsK0b2QSXtlL8hGY15kYNwhNYTZ+KV6sNTcg37WCCrRRIO/kaAoK5nqPoS5
         DMYuv+ZBm/aJo3TYHujrLa9VQTipSfYHL+zAxboBe8Ki7FmQ93YdPHCcHOERF6KQBWkM
         yY8cbB0tuoD0CY+gxLssoNxDZRE5go6spGTFD7WKpkWQ9YkEaow1hRbSfJoCO3cL7P3z
         BdXA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ylQy0TvG3aHF/ssMB08T2la7bhq6XXUETHIbT+50ZSsdroiWk0qsGFdjwYlYPN82ZehFhxtsS1H6nFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+nsR/B4S+G8I4aZv3ouVnXHwF+znjJwyYP3JTGtjQtdbiunE
	o6ZGhdJ2wMRxfCZ0wb3ocMUlMxMBPi8l3UlL6eEWTT2zrdQLhei+6TT5XrkFG4tqscWezCn6a15
	MYjE7THo11oJxKPoLuLjpgIcWmP0N3F5FyXhF3nSQ9ChwDf7pwCs2n3ax3JizjTVM8YGxbtVRlo
	oxS97dXtqxadOBbxi1TXCryAJN5JUihFcXIkRyWab/PC6W70db1HWtBw==
X-Gm-Gg: ASbGncsPw8ue249xINHBdNln7C4ZJgfP4EupZ8m4qrmkq6iF3U5G2h6+FgrBtnAQ+GV
	fL1gRbY2Ew4D3HHMZghkNu6ntTswHd2wPTvMHOfbLEv8WdhPGRE7mCbpBYBG2rUdT9nH1XLsomc
	geuGu2dTZK8r69g1R+uKVTPhqafcNnDwSgkm6K9YqX8WAsHNuh1Rwr6Q==
X-Received: by 2002:a17:906:9fcd:b0:b04:20c0:b1fd with SMTP id a640c23a62f3a-b302ae300ccmr331461966b.36.1758648894485;
        Tue, 23 Sep 2025 10:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq4BfWe8HxueShfdYzigmJ/VAJwF1XeJgNJ2hPk2d7C/yE2zIEX4Wl+YrY9HIBKFihHiry//0x0vN++dsU+uY=
X-Received: by 2002:a17:906:9fcd:b0:b04:20c0:b1fd with SMTP id
 a640c23a62f3a-b302ae300ccmr331460766b.36.1758648894113; Tue, 23 Sep 2025
 10:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922200942.1534414-1-rrobaina@redhat.com> <p4866orr-o8nn-6550-89o7-s3s12s27732q@vanv.qr>
In-Reply-To: <p4866orr-o8nn-6550-89o7-s3s12s27732q@vanv.qr>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 23 Sep 2025 14:34:42 -0300
X-Gm-Features: AS18NWBWOHf8rNDBSAWfxx9RxHlA_lLobyIxEA9zXAn2_ywMPGOuRbJS6DmvJVs
Message-ID: <CAABTaaDaOu631q+BVa+tzDJdH62+HXO-s0FT_to6VyvyLi-JCQ@mail.gmail.com>
Subject: Re: [PATCH v1] audit: include source and destination ports to NETFILTER_PKT
To: Jan Engelhardt <ej@inai.de>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, paul@paul-moore.com, 
	eparis@redhat.com, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 8:29=E2=80=AFPM Jan Engelhardt <ej@inai.de> wrote:
>
>
> On Monday 2025-09-22 22:09, Ricardo Robaina wrote:
>
> >NETFILTER_PKT records show both source and destination
> >addresses, in addition to the associated networking protocol.
> >However, it lacks the ports information, which is often
> >valuable for troubleshooting.
> >
> >+      switch (ih->protocol) {
> >+      case IPPROTO_TCP:
> >+              sport =3D tcp_hdr(skb)->source;
> >+              dport =3D tcp_hdr(skb)->dest;
> >+              break;
> >+      case IPPROTO_UDP:
> >+              sport =3D udp_hdr(skb)->source;
> >+              dport =3D udp_hdr(skb)->dest;
> >+      }
>
> Should be easy enough to add the cases for UDPLITE,
> SCTP and DCCP, right?
>

Thanks for reviewing this patch, Jan.

Yes, it should. I assume it=E2=80=99s safe to use udp_hdr() for the UDP-Lit=
e
case as well, right?

It seems DCCP has been retired by commit 2a63dd0edf38 (=E2=80=9Cnet: Retire
DCCP socket.=E2=80=9D). I=E2=80=99ll work on a V2, adding cases for both UD=
P-Lite and
SCTP.


