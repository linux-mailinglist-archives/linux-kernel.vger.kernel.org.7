Return-Path: <linux-kernel+bounces-891888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD02C43BB6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905F23AED4A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD822D9496;
	Sun,  9 Nov 2025 10:28:30 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E623D7CA;
	Sun,  9 Nov 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762684110; cv=none; b=jHaCRr2+edFXl7DfbwasztCYEe1x0GqZRqIOymFsM7C63kzwfBhLfSZqNSXIasAAOctLz6DAOYqnMYk4iMheL3b1/hiierTZA0pn7vNrNr988PjVfbWfprK+AbWvDIDvZe4kn9wAfCjAA8bgGDeeMBJ4T/ze+TiuG5AxwLWEXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762684110; c=relaxed/simple;
	bh=Vtdt2ClFhg5MYund+byt/uPsk8U5H/EMgf7bg/bA/GI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUmw9zpIaoiWdoFnNAdrDKwJk1GiOQxdWXKXtPl7i2ng4t86O1fRirxVN7DAVQ/3AaxnpDHAMDX21ILdTgZlIaOQcUZ4xxf47TKUoWqAHBRftTBqQP6feYH7jMycaoPpbtye/RRva9s+vuCfusvQO8ofMoHlp+05flkFDl28NGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (softdnserr [::ffff:81.182.156.58])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000008013A.0000000069106B8D.0031B2DF; Sun, 09 Nov 2025 11:23:09 +0100
Message-ID: <4a65d51ab0ad4171a21a746cc787c7596c022d88.camel@irl.hu>
Subject: Re: [PATCH v1] ASoC: tas2781: Update dsp firmware for HP and ASUS
 projects
From: Gergo Koteles <soyer@irl.hu>
To: Baojun Xu <baojun.xu@ti.com>, jwboyer@kernel.org
Cc: shenghao-ding@ti.com, linux-firmware@kernel.org,
  13916275206@139.com, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org
Date: Sun, 09 Nov 2025 11:23:08 +0100
In-Reply-To: <20251109070106.5993-1-baojun.xu@ti.com>
References: <20251109070106.5993-1-baojun.xu@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Baojun,

On Sun, 2025-11-09 at 15:01 +0800, Baojun Xu wrote:
>  ti/audio/tas2781/TAS2XXX8F62.bin  | Bin 0 -> 49824 bytes
>  ti/audio/tas2781/TAS2xxx8C70.bin  | Bin 0 -> 1756 bytes
>  ti/audio/tas2781/TAS2xxx8C71.bin  | Bin 0 -> 1756 bytes
>  ti/audio/tas2781/TAS2xxx8C72.bin  | Bin 0 -> 1756 bytes

Are these typos? Would these work with TAS2xxx prefix?

Thanks,
Gergo

