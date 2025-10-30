Return-Path: <linux-kernel+bounces-877862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B2C1F350
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314953B96FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444C233FE13;
	Thu, 30 Oct 2025 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NEYTi3ea"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462031A553
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815539; cv=none; b=ikeSPBuyRe6S7qaBaapfpptfU/0qfv/z1li4lbop+YmefhfhG4WqG0PPrtG8j/dE5yEqinibOBGP48HrXhGceuMN1DaA1v4MZWMrG9h9M8+w51JdBXa4wbiF+usTWEFz7WGCKqHLh/TnXhlJCxdXukf80/IAZbkVSVvC2+SCYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815539; c=relaxed/simple;
	bh=pmnmnwp8/m2ORAIlHAGqy0ONXoHyVhsFhWbawbgS1bE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hEzBRFL4i5UIO4qr1coZWG2isath74DseKKXwARqeMTvJK54MGoYyu1unC6hkIE91Lh3RO1qpMTU/W8cxxHttBOhm/eA3s50sJm+zP0rb8RrIeJwfGswc8Jf/BSob2aNDTm8m73dJ8DrwzICGosSaRnVRi+5hMFYxkytIKsSk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NEYTi3ea; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761815535;
	bh=pmnmnwp8/m2ORAIlHAGqy0ONXoHyVhsFhWbawbgS1bE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NEYTi3eaTKnDHama9LO6XQp1uZO/PAA5LyfYvmJ7PdrszOaepTIN0jD1LoDtfXCYg
	 CQxphSawKF9v3X5EpQMXhZQ6T9dMDNH51bpfeT+pN+1NM8QN2jTlKQNmtuxJmx1CY8
	 iTbu82LMkEz3U3/4fG5w0CD8zeFqeUaJWwe93gvD1eG/L+SoPOXJaiyDxEehEjk9Vb
	 CH7yW80R2ASFzdC5TJOXe5/TGxJCHWDfNKXwm+btbiKw4329ZsrumiBpHdiF6bmogp
	 GaNlVj2QHuYNhpey/pRXHjiyoumEPUmUD/++ndHWBgtmI2W03tCiz4h1h2jVW8YkqT
	 ZsyAE8yU+bH8g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 36C0517E139C;
	Thu, 30 Oct 2025 10:12:15 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20251029-mtk-socinfo-mt8391-v1-1-61412dcd9938@collabora.com>
References: <20251029-mtk-socinfo-mt8391-v1-1-61412dcd9938@collabora.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Add entry for MT8391AV/AZA
 Genio 720
Message-Id: <176181553515.11821.362759210116954859.b4-ty@collabora.com>
Date: Thu, 30 Oct 2025 10:12:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 29 Oct 2025 14:46:43 +0100, Louis-Alexis Eyraud wrote:
> Add an entry for the MT8391 SoC with commercial name Genio 720.
> 
> 

Applied to v6.18-next/soc, thanks!

[1/1] soc: mediatek: mtk-socinfo: Add entry for MT8391AV/AZA Genio 720
      commit: 781bb149dae361eab5c8c1ece4d4c8ea953ecbf9

Cheers,
Angelo



