Return-Path: <linux-kernel+bounces-896357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F3C502F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73653AF22D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A575D22541B;
	Wed, 12 Nov 2025 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLH03eTI"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4751D5CD4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910042; cv=none; b=j20voGbsLrkGC0HXXxnRPgBlHCKRfWPOC4CG5dMqg+kIm26uo/b0vDZeUmFlMLDiXe1PWlIL9v+PIWQtnSQmkfJG9N2AOZNbZhvBe+UZFDq5xiS7XhjSoxH/fcFHCZNDGnlyIHOS28SyFHjI1tAjX5VQjge6lYOblAQBpSUWjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910042; c=relaxed/simple;
	bh=XZ2lc74KyVVrREG4zhB8cAjGo9u4ikhiO1Oyz21vwcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3plhcGWPt0dD1XJjpe7PPnBNa//2Ap/dVDnpsr4zImJS12rz4Mv4pEPNUYF8eEysPf9P13h8ZNgviRI6u/bJraiPpnoFpZPZvirGfoLWXKJTyD5O+NEL7msdBW216n1XRffB6jihJaMpeKjAUcJWaN50GkHHAGMb+piLHEDgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLH03eTI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3438231df5fso352714a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762910039; x=1763514839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZ2lc74KyVVrREG4zhB8cAjGo9u4ikhiO1Oyz21vwcc=;
        b=CLH03eTI/Zy5DoUnGKAGQhPImGGL14sVKreLH/gMiJKzPbzjt+nUy1H46yWrpwNOk7
         xWHE+OtthqmuQVC4es9rFgvdzjMaB9PnGj0KDMeFFslgEQ2ugwMF4CB8kL14C1fV8oM0
         ak6i5Hu+ijDZHtOk6latFCejE5ugtzLvZrZRl+wjB3qmwVz7S3HQvJUpFM+t3S+qMX2V
         ndN4tSr0VVuI/piCBf6QmarcqAiPqz6KayzPf+wwJIcthbIjrpqtkqdGZZQFYngr4gkC
         R2CaNGI5PTTXvCfH9QRUV2i5mIcSepDRpn7q/alq+5lBRof3M/2E9cdITRN7rLFej+7S
         bZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762910039; x=1763514839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ2lc74KyVVrREG4zhB8cAjGo9u4ikhiO1Oyz21vwcc=;
        b=ZIcGh642N/6eX1IVIVNzTp+ZXo/BVBarg5LCQqXAg5ecRms66LfUYmgQgefxGuRrZq
         VFMaew4bwivHFx90Emg2tI8EueOOUcIJFw34E8rY+rKr1XySoGhUUhnltnFChSkOZR1o
         QDBjXZ/Ey3jhNmGFc07gjxoZfdztMi+BfYf3BnbgWnXPhfN0idH+N08tvVzx2tAEIwDu
         W73fR8+Fvf+vw6bCyINChXzUtfKKMb6jeOdT8iNJgSDeFUffbD/qKXmMzHtTaLSatA2Z
         gE7Q5++6PXnU2RStwDUIs6We6itBFYbPhKqRcmzcSD8jklvPvKsNwBH6UwelU3gfvrCN
         CCDw==
X-Gm-Message-State: AOJu0YydsqZaLnmat16CgfCvE4Oq0HUhA9BnHMgutMDntIXjhO9s+bgn
	dODrkafmpQexI0Qa8XnBsil07oNBgABggvfgRxC4x2MnvawpNG+Y9EoN
X-Gm-Gg: ASbGncvrD+kTM+JWzMp1hlhLGoto/CPOBUGssITm390c328DL5CRI3DHm1GOvujvJlY
	LqqDbsduxE4sfodgppAoqHVtACo2I9hQsOhN9EK6nsKCalTex+JSZB5vqTDv4/Vq8S5TjLZo+uB
	J91QbnvSycyXcqj9Az03+ORCI4KtJcPpVaqcrCNhWAJH7qo86Kquo4acLNUZHPy3gOzHC+ZOlYg
	thAWHJWtvby56ffvG7uF+VIrM/4IxRUCoIY/xWuaLEJ32IzOYD7i1TUSpDj7KjNC7SVyODnfGZ1
	qHJD5Kexgi+tTGo8qUlbyoIsXIFmdBXhRZi9n7skjmtG325l3gCNc6CSAfJSy/nU2D/uSJeRuu3
	pKqx9KkPRL71tWUdDLmJtiX5GQAGq2DzrYbwkJIutWpqSAV8t4COS/y1gChXq3oA2spOxjOGScN
	77WKo7Ep0v3fN/BUI=
X-Google-Smtp-Source: AGHT+IGmVXVOcEk+++9gYdT5vZS2t28n1mKBeSL++XpbAzlWU13n2vU3KLOXhWUVeVvZFIiya3Zzsg==
X-Received: by 2002:a17:90b:5252:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-343ddeadf56mr1617088a91.19.1762910039035;
        Tue, 11 Nov 2025 17:13:59 -0800 (PST)
Received: from [10.224.102.62] ([134.238.36.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm448403a91.2.2025.11.11.17.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 17:13:58 -0800 (PST)
Message-ID: <e9ed25a049ab88bb976f1b625d659c568434d93a.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a
 reset
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, hare@suse.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 12 Nov 2025 11:13:53 +1000
In-Reply-To: <20251111234519.3467440-2-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
	 <20251111234519.3467440-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 09:45 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
>=20
[...]

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

