Return-Path: <linux-kernel+bounces-870875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62480C0BE16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA03BCD99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32C2D8766;
	Mon, 27 Oct 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="UGln7ZOV"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7012D77F1;
	Mon, 27 Oct 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544564; cv=none; b=qzFEQV/F0zoA9oPN1Rpjvv5Wg1Dh6/9TovIkJbqwSGLzHE+UvXdaP9MvQIKXEpbSzi/Q9cwqApKtZwpqKBvdMxreBlDUFf1JsofR2g2MveCxUqaLXXU9hxslNfdsMI6zY3lPQuK5Ywux7wzTm0bRobD1y4+eyeNBXWRKi3m8aDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544564; c=relaxed/simple;
	bh=EfIQEjHO0SC7Aqmqkbs2O93BEaGxsZvcg/d6WWIvSz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqoVZxjVpxbX+UKgGJnfddR+0ekv3eNwEB0pwEUOx9BD4xc/fc+cNIDN1MRq2O13x6QGZaEQhtBqehUFSIVFkAQdYHC6q1Ql4BQJzRZsRUfzkNZI3R2lHmR35Eu2r9k5YLeCPi21r5G9sVuqsVz6JkkbCJznlQWfzpbZgp+GxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=UGln7ZOV; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Ljd/GfWV/LpuXLPWohOtAse3dPFW/ARWxabMfHqOTJA=;
	b=UGln7ZOVacTnbhninps24IXqlFlyB0RG1OMwWhYRwl2Q66TfPUDvmZ5zqU+Ilg
	lNSBDdkaX1WkqhLbbZh8cgtFdvdjG4N5XkL+WgoMa3UABxpAZEPfBkBM+F+FvST4
	Yut2bKfEvDVSHfm5iBPGs3QSKtbfZBAAJYc6aGGunIoGU=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPSA id Mc8vCgD3371JCf9o49s+AA--.49824S3;
	Mon, 27 Oct 2025 13:55:23 +0800 (CST)
Date: Mon, 27 Oct 2025 13:55:21 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mp: add idle cooling devices to
 cpu core
Message-ID: <aP8JScVXZo9nj4MY@dragon>
References: <20251013065903.35216-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013065903.35216-1-martink@posteo.de>
X-CM-TRANSID:Mc8vCgD3371JCf9o49s+AA--.49824S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUz8nYUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQtu02j-CUtMEwAA3d

On Mon, Oct 13, 2025 at 06:59:19AM +0000, Martin Kepplinger-Novaković wrote:
> The thermal framework can use the cpu-idle-states as
> described for imx8mp as an alternative or in parallel to
> cpufreq.
> 
> Add the DT node to the cpu so the cooling devices will be present
> and the thermal zone descriptions can use them.
> 
> Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>

Applied both, thanks!


