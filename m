Return-Path: <linux-kernel+bounces-802690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F2B45592
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D98DB619BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BDB33CEB1;
	Fri,  5 Sep 2025 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="gWSqpyMf";
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="aiQNrA+9"
Received: from haruka.juszkiewicz.com.pl (haruka.juszkiewicz.com.pl [185.243.53.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26030286439;
	Fri,  5 Sep 2025 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.243.53.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070163; cv=none; b=jG+bFsmIUMw1DI45/w2m6hSfy5a3TWM8RiCjNSrnFwXeRsofZ4XIJvPhp+Cg4lkZeAFByqiAnZEOvh7SvW4RqkL+n2VxBX3sU4bpWY7UBPyu4HJgygdaHzZiq4I+Bn/l/S7iyW/liV/GMaTqr7v3JyaJQHR76F5TsyeWd8MMHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070163; c=relaxed/simple;
	bh=0WWTGQsEQ9lzz7bJ7y89bwI1VZur0nT4lh7qtGAWR4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PaZquc5bnICvS430TepRv/l+YOoRMrSEUrxo9lvLiQLpXB+MHarpmYlGZM267rUagJ7n/HLuWApvV5/9g2NdqvgiUmNJrGVfvso8Zb7Xtl8AL2tbzybycQW2mc5cOHloThldOv2JIoWBa14BB8D899r2j13eNLpCBrCG0PfvhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl; spf=pass smtp.mailfrom=juszkiewicz.com.pl; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=gWSqpyMf; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=aiQNrA+9; arc=none smtp.client-ip=185.243.53.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juszkiewicz.com.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1757070159;
	bh=0WWTGQsEQ9lzz7bJ7y89bwI1VZur0nT4lh7qtGAWR4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gWSqpyMfGPMwxB+fAyLvrmVa3xWV7K6GM8o6Wp641za9iXv68v45NEJeGa9jul0hy
	 fbMbstBXwCdBPeHFxcYA6J7syabjRcCJpEW+JPkBMwHy3YeUEw4Rydlm6DLUzBrURr
	 cTBaANzIjaN8ZXhQdGJY4u6TWX1PlQNx39/nO6yoD5JkXVQmBjxmUfQ2QE/EF/q/Au
	 btdAUI00sAi/r6T7aCY33q3Op6xhT1wX7mi3U/pPq7HD1PEuHeMQwodi0qoWqQ6lxi
	 2jc1rVUfPXOVqJ/pzueRVBRinxQMMsQ1lWakq2m/FmkqSQv+4dhzDmX7svdo+so3BG
	 SBuS13MbFf8Og==
Received: from utena.juszkiewicz.com.pl (utena.juszkiewicz.com.pl [158.101.208.177])
	by haruka.juszkiewicz.com.pl (Postfix) with ESMTPSA id 70A751FB29;
	Fri, 05 Sep 2025 13:02:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB62B453F5;
	Fri,  5 Sep 2025 13:02:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juszkiewicz.com.pl;
	s=mail; t=1757070158; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=AQznFZ2/CAp5Ia9g3+t36AoVZFqyxkghcnOS1fDxNvI=;
	b=aiQNrA+9ezwZkkfwIxLK7lUExyZ+S4bj0MGCyYKQ2eqcljH/5xS/nNQ1J0ap8losZOWfTb
	NrNhAsr5MA3n7MdDTrAv6g1vFZuyv9gxH1lpfdxRA6peIA5wE8RvHmVVxl1o+WHDxrke3X
	J7vBDLAbbfTzr3iYsqLYz/Ro5jWKQcMKmEbxK8oANCUJqMJaJAML03F84aFQh5NPzEVu5T
	WaBN2vqNMadKGKtwn3kAIvJ8A6S03I4F6z63HUnDfnxvZ8OSKOiHQj6uWqUFJOdhkgb/Hg
	8RcbxZz86Fi4QMoWuA9bEUr+JHfpehWh8DHAW3GYXrL65HYGL1PFOL259PwJQQ==
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: [PATCH 0/1] Enable HDMI Receiver on NanoPC-T6
Date: Fri,  5 Sep 2025 13:02:29 +0200
Message-ID: <cover.1757068166.git.marcin@juszkiewicz.com.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

For quite a while I had this patch in my local tree but never made it
work. Kernel generates the following messages all the time:

fdee0000.hdmi_receiver: hdmirx_wait_signal_lock: signal not lock, tmds_clk_ratio:0
fdee0000.hdmi_receiver: hdmirx_wait_signal_lock: mu_st:0x2, scdc_st:0x0, dma_st10:0x10

"v4l2-ctrl --all" reports that HDMI In is detected, /dev/video[0-4]
exist.

I tried two signal sources:
- AMD Radeon WX2100 (via passive DisplayPort -> HDMI adapter)
- AMD Radeon RX6700XT (HDMI port)

Same situation with both - kernel messages as above on RK3588 system, no
connected monitor on host side.

Usually I used MPlayer or MPV to check v4l2 devices but here it fails
too:

$ mpv av://v4l2:/dev/video3
[ffmpeg/demuxer] video4linux2,v4l2: Not a video capture device.
[lavf] avformat_open_input() failed
Failed to recognize file format.
Exiting... (Errors when loading file)


Checked SBC schematics again and HDMIIRX_DET_L line is GPIO1_D5 like it
my patch.

What I go wrong?

Marcin Juszkiewicz (1):
  arm64: dts: rockchip: enable HDMI Receiver on NanoPC T6

 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.51.0


