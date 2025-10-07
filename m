Return-Path: <linux-kernel+bounces-844771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20CBC2BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA64F3C818D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56832459D9;
	Tue,  7 Oct 2025 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR/b5HeU"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3F1D7E41
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759871846; cv=none; b=ZJqaeb6NU28UkVa8DNiIGHJgQ+1u+a/IhiNI8AQsvYUIgfW8tAiISmhgECgrOM5pO3T2K0poIqaeG4Roq1IxYvGaAY/eBkwzDX5FsPqb0DDsK8AmrbRHFAlKs6RmSWwp+yw7oClKTbwL2MUsw3z8yLp2WDVZIs/rn+irZ5dfYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759871846; c=relaxed/simple;
	bh=O2a4hpClmYRea+Tz3568r+v0GbBdMvAVZjXucR/S8zU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=d6LTpliZKJLGj5zLbj22auLx6MgM8+iOzMIW3QO/oA4q4t2/R5CGYChGdSa9gu7Xs+CZoZeijyLt2ruQB1J5rJLZGJyelbNlCe1pXkQjHulLIwdvK7FsTIUedk9x9//yNQ8Mot9tI9J8HzSz4mKFJjJqcD6zZEB2d//asKnnn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR/b5HeU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso58022031fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759871843; x=1760476643; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftuvQ7HxIwpNGwMPJIptGZfQOoWM438e/cH1tRd24CM=;
        b=QR/b5HeUw1j4G+JvJHx/MycXPSCk737OOtZib3xanyf/Q50/aCNHN7W8Tuu8G4Qris
         yABuDAb1WbpgbAEGsv1oKBEW+eIGBh9Up+ht0DPnUPvSSpG5b6sAEPFxZxTp4+E2zD6p
         XolZhFSyRzzCLX6y3IKfLaLd7eDNmuHdVKsnp/0xcKHuuP8MhiwBOtMtlpCVChTjp1fs
         rcJgWKZSb6I7lLxizqpRo8e/qnUQVgPrFCwdrEZ5YedTltwoNKKXhCtuHFK6PN8iSx5W
         wHDRWgNhtgeylqZUeQ4p9EFL9IQ35NvpGjspHaxclSNDbZxykwRtsh1N3LEtnkpBkryl
         U73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759871843; x=1760476643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftuvQ7HxIwpNGwMPJIptGZfQOoWM438e/cH1tRd24CM=;
        b=hwDJJiufooZ7ykAnzBabgBCagendT1z4PWTx8OxWez0xQ/t23YMb73yQHVg91M9AlL
         YsUJhnmnH6myQhD9GUNqTgTtI/L/P/cOkCMCD64ckrrWWMuWVQH4ZssZAcayQInP7FRI
         nSeAmVQdrMqXjIjN5WY1SCm4Tdco3vnaBEh1OhlUZChldl+7RNESM0/1V60efOkIZ6uY
         znW8UuoEyO8/3ojwZojkucy+AKLiF/Z1wnnvMDczQynp+TOur0mWsY9jC5ms+ELsUEF7
         whe4PxeR53mKvFtbLWKP4i4+8h+rMdqPwOn+jHgKX5b/VIklDEUKuQjvhWsESUt+N3cg
         GGKQ==
X-Gm-Message-State: AOJu0YxDiFbagimisi8pzXjrJP+5+XTxnWZUexexG42e9lA1dZCC0jwB
	35j0mhXTGVDNJXlUazN7nFB39vewJDrlSOYOob8ZxGhwJa2E3awvCj1E
X-Gm-Gg: ASbGncuSbnmiSXalwNR2cgxxe/sThaaAo53J3GQUA4Xq4wqQyaa3mY6vScCzIpoRZWn
	7kx1bqTUs3pnUQjUfvyhawUmgZwmM4ViF/OCbobD7V0HrZpuILNYYsRqELzcwG+f6tKm9zlbJzB
	I2slvsDtKGQxaVUxmtRaAbwRBR8SUaewME2rTxU8uJEcgEQ2+/bLfBdOtHHr9RVonIGLGLqVPxv
	N87O9UL11Q79U05KZbkFH03L5GIFfzFCV6cMU8fuc87aMMb8xN7dBa11i+wXyQRbzeVkQJZIqjZ
	gNPZW2+6xgR5eHT4sPg7nu04axwJw9Ro9npPzEa06rRTviizkvY/ziNZcS7wkzueB0yWtUwah3a
	uiURnE0Ym4IPlbHd2KwIKUxisWiLuZyy09OYz7l/PqToG7qNHUw==
X-Google-Smtp-Source: AGHT+IF9Qy2hxi4Hi16npMFdiq+gHqfM+ZPfuEAdpHnoVF4XtrSt9DulagEFuvWw9aQKppWXI2EYeg==
X-Received: by 2002:a05:651c:19a0:b0:336:9232:fb9a with SMTP id 38308e7fff4ca-37609e93234mr2591221fa.29.1759871842285;
        Tue, 07 Oct 2025 14:17:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b64349sm13648291fa.33.2025.10.07.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:17:21 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Ulf Hansson <ulf.hansson@linaro.org>,
  Shawn Guo <shawnguo@kernel.org>,  "Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
	<87o6qjaiz7.fsf@osv.gnss.ru>
	<CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
	<87jz17afpb.fsf@osv.gnss.ru>
	<CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
Date: Wed, 08 Oct 2025 00:17:20 +0300
In-Reply-To: <CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
	(Fabio Estevam's message of "Mon, 6 Oct 2025 23:05:06 -0300")
Message-ID: <87bjmih0nz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> On Mon, Oct 6, 2025 at 6:22 PM Sergey Organov <sorganov@gmail.com> wrote:
>
>> It is built form multiple .dtsi, so I figure I attach the one after
>> pre-processing stage. Please let me know if you'd prefer I rather
>> manually insert all the custom .dtsi into a single .dts, and send that
>> one instead.
>
> This format is hard to follow.
>
> To make things easier for debugging, you could create a minimal board
> dts file with only UART and eMMC nodes to reproduce the problem.

Please see attached minimum DTS. Maybe it misses something? Shouldn't
DTS describe how eMMC chip is powered, provided it's powered from NXP
MMPF0100F6ANES PMIC? I didn't find any hints in other DTS'es.

> It's not clear to me the relationship between the ANATOP regulators
> and the eMMC power on your board.

Sheer mystery for me.

The point of hang is not entirely deterministic either, that suggests
it's some power problem indeed. It may hang after random line among the
following depending on exact build and sometimes even from run-to-run:

...
mmc0: SDHCI controller on 219c000.mmc [219c000.mmc] using ADMA
Loading compiled-in X.509 certificates
clk: Disabling unused clocks
PM: genpd: Disabling unused power domains
check access for rdinit=/init failed: -2, ignoring
Waiting for root device /dev/mmcblk0p2...

Also, I just tried to compile entire kernel with -DDEBUG, and it starts
to see the eMMC, though still hangs not ever mounting the root FS:

mmc0: SDHCI controller on 219c000.mmc [219c000.mmc] using ADMA
Loading compiled-in X.509 certificates
mmc0: new high speed DDR MMC card at address 0001
mmcblk0: mmc0:0001 IX2964 58.3 GiB
 mmcblk0: p1 p2 p3 p4 < p5 p6 >
mmcblk0boot0: mmc0:0001 IX2964 4.00 MiB
mmcblk0boot1: mmc0:0001 IX2964 4.00 MiB
mmcblk0rpmb: mmc0:0001 IX2964 4.00 MiB, chardev (246:0)
clk: Disabling unused clocks
PM: genpd: Disabling unused power domains
check access for rdinit=/init failed: -2, ignoring

-- Sergey Organov


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=javad-minimum.dts
Content-Description: troublesome minimum dts

/dts-v1/;

#include "../imx6sx.dtsi"

/ {
	compatible = "javad,imx6sx", "fsl,imx6sx";

	chosen {
		stdout-path = &uart1;
	};

	aliases {
		mmc0 = &usdhc4;
		mmc1 = &usdhc3;
		mmc2 = &usdhc2;
		mmc3 = &usdhc1;
	};

	memory@80000000 {
		device_type = "memory";
		reg = <0x80000000 0x40000000>;
	};

};

&usdhc4 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc4>;
	bus-width = <8>;
	non-removable;
	keep-power-in-suspend;
	status = "okay";
};

&uart1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_uart1>;
	dma-names = "";
	uart-has-rtscts;
	status = "okay";
};

&iomuxc {
	pinctrl-names = "default";
	imx6x-sdb {
		pinctrl_usdhc4: usdhc4grp {
			fsl,pins = <
				MX6SX_PAD_SD4_CLK__USDHC4_CLK		0x10059
				MX6SX_PAD_SD4_CMD__USDHC4_CMD		0x17059
				MX6SX_PAD_SD4_DATA0__USDHC4_DATA0	0x17059
				MX6SX_PAD_SD4_DATA1__USDHC4_DATA1	0x17059
				MX6SX_PAD_SD4_DATA2__USDHC4_DATA2	0x17059
				MX6SX_PAD_SD4_DATA3__USDHC4_DATA3	0x17059
				MX6SX_PAD_SD4_DATA4__USDHC4_DATA4	0x17059
				MX6SX_PAD_SD4_DATA5__USDHC4_DATA5	0x17059
				MX6SX_PAD_SD4_DATA6__USDHC4_DATA6	0x17059
				MX6SX_PAD_SD4_DATA7__USDHC4_DATA7	0x17059
				MX6SX_PAD_SD4_RESET_B__USDHC4_RESET_B	0x17068
			>;
		};
		pinctrl_uart1: uart1grp {
			fsl,pins = <
				MX6SX_PAD_ENET2_CRS__UART1_TX		0x1b0b1
				MX6SX_PAD_ENET2_COL__UART1_RX		0x1b0b1
				MX6SX_PAD_ENET2_TX_CLK__UART1_CTS_B	0x1b0b1
				MX6SX_PAD_ENET2_RX_CLK__UART1_RTS_B	0x1b0b1
			>;
		};
	};
};

--=-=-=--

