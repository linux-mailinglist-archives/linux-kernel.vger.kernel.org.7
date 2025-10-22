Return-Path: <linux-kernel+bounces-864224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FDBFA361
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844EE5681E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006372EF64C;
	Wed, 22 Oct 2025 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHYppg+q"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973E2ECEA8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114292; cv=none; b=QqGaivChs82fIk5VmQeCzOs5lbNwsHE2axy0a3VhDkWrpD1astv+4AlfUuj+3m3PsnqHSRT7L6DILsWXdMdB/9S2DvlZ4B4aermyDtx15vSO1eZZ4aBywlV9J7XLIyO7XQ9NpSxXUAoWzYK2qiKpJz8vuRQTWk2AtryLhrJdmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114292; c=relaxed/simple;
	bh=YLaExqYW1fVHSoQwhG/jrBMMCT2WCCtmI1lRmIdKDvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJsODAHvnMfVhcm3BA2lLziyOO0XGErQyY9VO99S2WMYWAa0IZm42sAaOIT/DPWcC1l3uAglVy1WuKhADBSaNaIvYQON5goQ4izJy5vhAg8JaVK8nbobLhUIRbBi905Pb7N4/wkYvG8yXxHP92Z7T0iUIkoutqCUxufr0vhpjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHYppg+q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8411134b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761114290; x=1761719090; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MnZkr7TjjA5oyXjysydnhLnRes3dsjebDwBOG2wiF6w=;
        b=VHYppg+qaNO3aymXi8YpLUN8myddkUpHZkA9x4YnuP/D0M9CIFwLVFc44Oh5YeEMEt
         x1gEdQTaMHabnAcOSQ3ekqDRKdbp18otBHV3++DH5JYgmzntMgmuDOelJ16LcLlXD6Pl
         QHKgHnvhFj0F8Mr+Z5rQ1nZPuEgWHnw3pl6ueiWkDbb4GiYzvco7n0RenVaTNukEuynh
         crEmkTN3tj6N7otIuzY2nKzOetRR4FfrpRUVke0mx9kSMO7JyLxGD6DpdwoX7Xo9S/RG
         nyamkrMsYmaETChCHqDtxvhWChPqh1tJmQsHTvUxPw/k326DDzGfj2JZaC98iBGMJvGy
         sfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761114290; x=1761719090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnZkr7TjjA5oyXjysydnhLnRes3dsjebDwBOG2wiF6w=;
        b=C+Pnyh32iBysfHr7wQRx5JdQ5664mGunT3Sjji5xJxmp+sbEa2tdrTHHFcvjSeQq5/
         JRc/2rRJfqXQT6bryPAz17JYBZ+3r54RFBlaglsTaR4vwnqE4Idv+VvfwERGVA+R+eLY
         xO07EHcvtXOrTs+GmK/NkdcN2dwhWthJm2TV57WBhyMfI1mo0Dui20TPRpBsq5KrFRy/
         fyrXzpf2napLYLVOJM6gHBAI+WbHm/WJrIj5dDMiLGVGHOZiZVkiG8077Mg+L0JPZov0
         3Uyarh+6TmU80jJ8QJNB4nzfndKXzyyEksVdXYesO9075jPUCk6HgzGQMGPtUg35mzE3
         anoA==
X-Forwarded-Encrypted: i=1; AJvYcCUH/r1yQax+W+gTIIa0Dkp27WdXvYZ0rsvi+hHI9j47X/k5jHWjnsB2D3MNSzN+GnhWf1TW1j37JaRX6Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlyga02IDAJBxT6ImJHykrnYxkNgXxduGteF0bbFV8PzPztork
	cd7EV8jww9/EIQL7IncqRnFmfbQqfp1c2xZUDM0Ynw9swPobIdHNU29/
X-Gm-Gg: ASbGncvLRi9KcWNEwi1jG2nJkqvhTeXzfUIu7Wd9qrJ57rQA4PMke5ORuxM7nVtOP4f
	2f2Sw0swRHwFiI86tAUauiT5oo/Z0XM1M+APfJuXjPtcldgLe94wKx13Oam9c8kuC2UtLb7cJm3
	ynDAHOCkYOb2rTLpeonhyUANunkFviaSL10RwnDaDWs4mET+xzH3aP3M5xE09WyjX4035f4BjS+
	VkCL0gTged3syPdiAi0tkd9tso3Y+WQKaB5BqVaB26GHzCdYEgbB3Pmyru2qc3TXIlATjU8vn7T
	1K4iTnenqhaMFJ2pHKVDr0w2RNP2tMW+nJDula54B1Ud9UcEUpKeI4NuGgMkJmQsS2oHJhM6Kx3
	Bv+xk3fjRoVGxX5VWRytEFhiOwgMdP4ent9+MB1A/cC6ep8lVPipEhqRkfqpUxB6UA10hmBdtsq
	QkvTsp0ApfqUqL708FYQ0=
X-Google-Smtp-Source: AGHT+IEgKwi/63UPErEmWe9jK1Imyd4ft7M/bxL6w0CSUK3SnqWRR+2qFCNjFY3yItXU8IxKbojv1Q==
X-Received: by 2002:a05:6a21:6d8a:b0:334:a180:b7ac with SMTP id adf61e73a8af0-334a8616ff5mr27091997637.39.1761114290218;
        Tue, 21 Oct 2025 23:24:50 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34ba6sm13441565b3a.18.2025.10.21.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:24:49 -0700 (PDT)
Message-ID: <ee6739203c5dbd7452541a3915636b597b34848f.camel@gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: Add debug message on fail to read CSTS
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-nvme@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 16:24:45 +1000
In-Reply-To: <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
	 <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:29 +0200, Gerd Bayer wrote:
> Add a debug log spelling out that reading the CSTS register failed -
> to
> distinguish this from other reasons for ENODEV.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> =C2=A0drivers/nvme/host/pci.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index
> 7544c4bac2c4a230d32cf729abb9e94bf93a921f..c3b0a9d56ac1f32f67ce0890bec
> d6425eb80ebad 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev
> *dev)
> =C2=A0	pci_set_master(pdev);
> =C2=A0
> =C2=A0	if (readl(dev->bar + NVME_REG_CSTS) =3D=3D -1) {
> +		dev_dbg(dev->ctrl.device, "Read CSTS register
> failed");
> =C2=A0		result =3D -ENODEV;
> =C2=A0		goto disable;
> =C2=A0	}
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

