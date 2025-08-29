Return-Path: <linux-kernel+bounces-791669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6B8B3B9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AF9A217CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA013054DB;
	Fri, 29 Aug 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjxdYc2H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183427934E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466712; cv=none; b=GFQwkmWMX99PGPFGZZDI2MY1qxos/7vujoxqxmArpG7UYQ7sWSUEacor2qWOygwsXPWHfDC55IWL6kKkkanDe2ft/Q73D9esToh2yfoVBMRk+CGz33Y3VR94gnxaA56fwQr25sIjUJ4B/IES07vEZBpd+yiVpB+tx7zmYC6Jnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466712; c=relaxed/simple;
	bh=6BFQxgM0oh5DVS5xIr9d7exSQK21yLoo9WBRstJGdHI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gYbJwBXp64muXLVkqDAzf9RjEaIPLDdHoeocGy4dPK4XCOeh+SPecaQ/+vnyq5/4gxe1V7sC6VcQSRQwJruFKFXrxmYK0/rp9SqBI2PSO17Qdl6rugUeg87tPney6jfWLQgWDHKzbLsdt/cSArSRskf1hogfUDJ/OvEfppaGcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjxdYc2H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756466709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=H5DSrH7S/YL0DhZrQaaJj+H/G5K8+6JE30rwyPkkkH8=;
	b=JjxdYc2HHonmqoTQrsym/CpdIziDvCfATUml5KWTTMrezMoVzfiB21pwi734VnI7fvZenU
	dOoPCXNMYKpvRnoXbhbkeikUsajJ+G3o3a0hljmNrs89F+w55zTem/Qkw01RDtF7r0aEnD
	4XqAp4+SHw345ik/DV2OJl08b8V9NgY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-1gqD887BPwepUVBtoJRY6A-1; Fri, 29 Aug 2025 07:25:04 -0400
X-MC-Unique: 1gqD887BPwepUVBtoJRY6A-1
X-Mimecast-MFC-AGG-ID: 1gqD887BPwepUVBtoJRY6A_1756466703
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afe73808e6cso185205466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756466703; x=1757071503;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5DSrH7S/YL0DhZrQaaJj+H/G5K8+6JE30rwyPkkkH8=;
        b=psZndbZgnrA1uYMD6OiPW3N9De+42xHYG5UEvDVqrxKZ79uTINf6OpI2kma+hE9eBG
         wtegN1FK4UgJgrEOzKIEmZLNRA6XdCTLfmYfUB+oOxEzlkNYQW1d3Kz6ZluW8Sskc7qi
         4drO1rF4ef/VnKehfZCR1259afkyopEfNb+e88AN83X/ygNtxBVM7zH6kcZBqFkMBW6j
         DhnoM5VvcMl4XS3UyIIt7429GcL5cNMoA+A1hs+clCl/7+/rrOMEku7YaVUfcf9zIUuv
         hjP6ER0+byy6u7rZTxfRq0q99B6gSTE7yU9IVHic0xt2r2uv0jmjgSj/RCvwOmuo4BXj
         Ae5g==
X-Forwarded-Encrypted: i=1; AJvYcCW/Azod/Ps7R0LCeJmKzPzsaocx2/FVJHEEdt/UqTJm7AYZsT3sleSaQL16JqaDmyj0uaguitHnjy+NDFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0tcZciR+3iAAo8mfXm8KAL4BtrFY+MfHVD5MPfos1bg9yYX8
	42axIHiw3w5uthESyvwvlUSbC+8bbI0ChBCG2xCfsw5dmbC4hvWpz9Da7L6ufE6tn5ROmw6WNZY
	ZnLHw8QhxslCBKmvP00MyaQj5JSluvn1lWrNaIvNRs+lVWiRs1FfDLPQtoZQtZZrSyzypz0+2ur
	cmNZI4eXLeWM4Bgg1wGHrb7KTUur4ptYGbuVWm6iN6
X-Gm-Gg: ASbGnctTE1d3NUW2PmGYkhi8DYzLUBnixqh2XcmA9WOdfM1UMruvK1wkBpYLWaGMuSC
	jWCvk8hxoin+2tfI0kzz+jKu2Kl0tR5uZIvFLZB9k0EShJ+qLnenwNUwDTgWIp8do2V29SEoEgf
	/X0J4mBBSkPKY1Z7qzKr4xt2AOTZV7urxi7AlPHwMJUgGnZ03kVtPa
X-Received: by 2002:a17:907:7248:b0:afe:839e:d10 with SMTP id a640c23a62f3a-afe839e3cecmr1780883566b.31.1756466703371;
        Fri, 29 Aug 2025 04:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDUAydazSnnhFhQ2IS/7xxn5zNZxC7KkqkPr1qBMJMM9fvjQWnwmefjaIofovb26bMZHJC4dwIv5EeZ0pSjP0=
X-Received: by 2002:a17:907:7248:b0:afe:839e:d10 with SMTP id
 a640c23a62f3a-afe839e3cecmr1780881266b.31.1756466702991; Fri, 29 Aug 2025
 04:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 29 Aug 2025 07:24:51 -0400
X-Gm-Features: Ac12FXyyk3VCSqAncN0P6PmazJ4uiOf2K-91_nf2hLatGLxa_FrGw2-c_4CbC0k
Message-ID: <CABx5tqJ0+1bjoMM4qPS94coa0wyQaae1gJP14pUKk+xVgD5kaQ@mail.gmail.com>
Subject: Bouncing email for Renesas Versaclock 7 Clock Driver maintainer
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Geert,

The MAINTAINERS file has the following entry and Alex's email address bounces.

RENESAS VERSACLOCK 7 CLOCK DRIVER
M:     Alex Helms <alexander.helms.jy@renesas.com>
S:     Maintained
F:     Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
F:     drivers/clk/clk-versaclock7.c

Should this driver, along with clk-versaclock3.c and clk-versaclock5.c
be moved under the drivers/clk/renesas/ directory?

If not, is there anyone else from Renesas that should be listed as a
maintainer instead?

Thanks,
Brian


