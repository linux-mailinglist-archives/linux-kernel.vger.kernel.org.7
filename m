Return-Path: <linux-kernel+bounces-834219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98166BA4356
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2AE176942
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B842D21858D;
	Fri, 26 Sep 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="FuugvlCa"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D52116E7;
	Fri, 26 Sep 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896950; cv=pass; b=mg/Hdyr0bOQnno6d8rs+LZwyhEhijKb4F1rwaywNRv3uY5Y1DfDebbk7CSWas9oTDuvHtUWXtSMLad3ymE34UGctoNEcvGmSeq7CYww9s+9M53A4M54a5mu5gOqjF9jRH3quUxUPwGDI8UUWn27K/dpmtLYfJ8u2ON3yIVV/Jck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896950; c=relaxed/simple;
	bh=Tmlfs7vmbvrGil0urNAjBMrst5tp49VMQUUOgrwI7kA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oamiahVcgagyrYon+9UztVIBjoWtoqusxGQ/l2i2yWQSqo4y99tFhen1geQjR/6REv9qJvK0bzAF9SownNqg5wRDkYDW3v4sggpX6w0CvaHLHZUSa8iMGcNpiOaTOam43tjc0gaqWdOt38cL2hQew912uLHiGOwNVfwga9C8NWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=FuugvlCa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758896933; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LiL02BSGQZ5ytPMrAU7fzsgyGu004PQCrF+o3pkV49Gn0Naaaagx2MrWv8h17/ieZ++pzWEfHBvf/QnC+C2tT3Lqwdy8XJEmdpTIgk/xQZMvzFmAmuTDyr0ujrlEnijRtUQTEuHzXmHxHlbtwTYEewNRPkXAGCziAJ77cqhCoMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758896933; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=26YfjhR80XqVvp3T4GXiOY1ZVSaa9CIx9x33j2hmPnU=; 
	b=Arha/5GW8rJzpUz+TOpn+9ORBNoQxtxhJFG8vE5Gqzi3c40hk6jfC6gyiNNq922ZO7waYSY3++nyDIH4eFUp1ICjzqU4xjhQeXgx/VvyonGqoY5DWiWfot+uZ0UtAettFA1wFwjCC2KXKfIJMuqRQm2U6USOWeFUfomqE5kZPCc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758896933;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=26YfjhR80XqVvp3T4GXiOY1ZVSaa9CIx9x33j2hmPnU=;
	b=FuugvlCaYubKjIun3Ml+KCPMgmQsDCkyyh/gcIASO2PnatTX1la4+bNybAn2e/MG
	Ol4fJBOMpEHcovpSXMfBvJvsmeTLv927ykfl4RNovCHrf/OZrR/I9UlFcgzWpdu651M
	KNKe2Utdu20BgSVudn6qATfOCn47yxZYm3wY6A9A=
Received: by mx.zohomail.com with SMTPS id 1758896931799989.2968902254092;
	Fri, 26 Sep 2025 07:28:51 -0700 (PDT)
Message-ID: <638b9565b90714f56caa9535b7b9b96cd86100d6.camel@collabora.com>
Subject: Re: Support for Rock PI-4b
From: Sjoerd Simons <sjoerd@collabora.com>
To: Mostafa Saleh <smostafa@google.com>, devicetree@vger.kernel.org, 
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip@lists.infradead.org, open list <linux-kernel@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Heiko Stuebner
	 <heiko@sntech.de>
Date: Fri, 26 Sep 2025 16:28:48 +0200
In-Reply-To: <CAFgf54oYjUEg9KkQUzneYTZH1Z8cX56va5M0853eWPFaYT+Z2A@mail.gmail.com>
References: 
	<CAFgf54oYjUEg9KkQUzneYTZH1Z8cX56va5M0853eWPFaYT+Z2A@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Fri, 2025-09-26 at 15:07 +0100, Mostafa Saleh wrote:
> Hi,
>=20
> I am trying to run Linux[1] on my Rock PI-4b, which I see is supported in
> the kernel in =E2=80=9Crk3399-rock-pi-4b.dts=E2=80=9D.
>=20
> However, compiling =E2=80=9Cdefconfig=E2=80=9D (ARM64) and flashing my Im=
age doesn=E2=80=99t
> work,
> It just hangs before any console (even with earlycon), I tried to also us=
e
> some of the vendor configs with no luck.
> I did some research and found that [2], which indicates that the upstream
> support has been broken for some years?

We've got the Rock 4b in our automated testing lab as part of kernelci and =
other
efforts. Upstream works just fine on those boards, so it's likely an issue =
in
your setup.

See e.g https://lava.collabora.dev/scheduler/job/19978558#L525 for a recent
upstream kernel boot.

Regards,
  Sjoerd


>=20
> Has anyone tried to flash a recent kernel successfully on it? or any
> tips are greatly appreciated.
> Otherwise, maybe it can be removed to avoid misleading other developers
> (I got this board to do some upstream kernel development on)
>=20
> [1] base: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
> [2] https://wiki.radxa.com/Rockpi4/dev/kernel-mainline
>=20
> Thanks,
> Mostafa
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

