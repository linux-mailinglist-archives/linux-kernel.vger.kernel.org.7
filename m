Return-Path: <linux-kernel+bounces-720099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135AAFB712
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CF13A8C34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2B2E11CC;
	Mon,  7 Jul 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="G6uDGGGE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE5288CA1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901412; cv=pass; b=Jgb8DXSTytWliSgiGii6xczCzlFBeysdK1J7YtXzdn3olXXghlqJ3AojHMmeO4qn7k8n147afDJVEBpgCAG7xQRYpzOBwPrTC4xhLygjm7Vji9kV6EyKK8zTymtZjjKCrwikWiHbad8mrHHcrnLq/pmSY5Syr/abDH8ZnEo/udE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901412; c=relaxed/simple;
	bh=8shiV2SIGvsW4Z77wfkc0qYFz0BxMMmYW6MQexAa7WM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwqRX4navCjc2S9PkURz2Ny5+KcCjjSzNXyDOg5NA9URCcqCqfzTG0QGXwnBRIVT54WWppWeIspwUF/aHWeV0TAu8vGjxNw/K5PwT6OfrYnIuVaG0K6vOw0NtS6eeZhuqZqZZLNmhExFj+scrsW0YdtGwLWN2kSdAJQH1QFM3Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=G6uDGGGE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751901394; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iVRQ3Lj2nQGEodePe3GMWxLb1rOtAzDtjebSjaDHNQK50PlibNfw/V8hKbG85AxFlV/Cx7ZRY3RzXJMhOQ+8kQt2uqaEckpOHXq8aWKZM6jCXehtrGAe5CSuFd69QyvPlqqpMxvsO+0e5ECFDhwFwWitinW00N8S6kqpWCjPQtE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751901394; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8shiV2SIGvsW4Z77wfkc0qYFz0BxMMmYW6MQexAa7WM=; 
	b=Z7LwoWzPK0pH+GPWgEool1Hl8FpuFKvCuxAe7mEZJ698nuQDeiK/8DLemUgu8WDo+fOp3tKpb5epOxeMapkaZ6lQD8Ss6/qrs+a/CocOBSsW8L9PJUkrCdwoeG6T54WuPzMOdSvUKgemGLsw0PTmEW0rJlQErwzdZ8bVCpZpjF4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751901394;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=8shiV2SIGvsW4Z77wfkc0qYFz0BxMMmYW6MQexAa7WM=;
	b=G6uDGGGEueurk8Z0HKEKWQrynUTviepXnHnSGHaGvjENKBBi0tFqharDThrkZ1Jm
	vWb51Ymc3t3uCGSq5B0mK4htPs+IkbmdduhLawXrIvqJztGquuefpHPrt75LG0bMo+K
	RWYa6WmxMgcEXSHgjJ8opoksvbHmgEAhIi81MB0o=
Received: by mx.zohomail.com with SMTPS id 1751901391054951.8771545064749;
	Mon, 7 Jul 2025 08:16:31 -0700 (PDT)
Message-ID: <2eb94b4390d7ce859b2e16f9b6abcb075776ca78.camel@collabora.com>
Subject: Re: [PATCH] arm64: defconfig: enable XSPHY driver
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Matthias Brugger
	 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	 <angelogioacchino.delregno@collabora.com>, Catalin Marinas
	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-mediatek@lists.infradead.org, kernel@collabora.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 07 Jul 2025 11:16:25 -0400
In-Reply-To: <20250707-mtk-defconfig-usb-phy-v1-1-4a5dd0d26402@collabora.com>
References: <20250707-mtk-defconfig-usb-phy-v1-1-4a5dd0d26402@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2025-07-07 at 16:28 +0200, Nicolas Frattaroli wrote:
> The mediatek XSPHY driver is required on mt8196 for working USB
> support.
> Enable it in the defconfig.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

--=20
Thanks,

N=C3=ADcolas

