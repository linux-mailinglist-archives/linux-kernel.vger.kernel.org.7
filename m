Return-Path: <linux-kernel+bounces-858991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A2BEC6C0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5935352E74
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6652853FD;
	Sat, 18 Oct 2025 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Q3GvJEB2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFsiRHb+"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD507288C34;
	Sat, 18 Oct 2025 03:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759746; cv=none; b=K5ndWuV/45oNBnSmPRQ/aLS576OY7WUweyouYhc5Pjuag+Kjb0vuZFLH5a+5P6MvkelNc9sxXV+LksHWBEXcEb/QyOfX7RpqUz2CWzs5x4AMjBAvagpjjukOQndsKCc5WUv7r3pVG8uM3MM86YsRItv0f74XRaLbiridqS4csik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759746; c=relaxed/simple;
	bh=NoQB9jvo/lj/F4d2DrjGprzN8jy2Gy1DaI/zECBTSss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ/nFAQEZe9X/RODiDg/NCkVkD6hXBSgG2p8TMjlEpyBi9JoW2ZAOoqiQwdf/A0qJlBj584NRjFOcesmKbm7qfkk7bUoPterpTXwoeTFxzTcD2ZUi0Zgd65wLLXKAwNfjuX6bg2etseO29VpWtU3AVyMyAkgEy133vDYO+VQDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Q3GvJEB2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFsiRHb+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EEC861D0014C;
	Fri, 17 Oct 2025 23:55:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Oct 2025 23:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760759743; x=
	1760846143; bh=O1OWHiw1ISX/XiaSgOMO5lUblMBfevYTme7V5wEqPbA=; b=Q
	3GvJEB2TOTodbuldWv5xNSegMOP8BgIuxjug90YgXoUrBvz7RCZWiW0VnQwA/Lfn
	ULGPPwUnF1gHYeu2caoULUwVi9rwrNvWGMZuLbYyNvGnxgLWPVrRMp8rE2vfcDAA
	BVDv9Ehjuf7DUtk0r03Fb61feZDKhw4vizZYuPmbkjiVEythkv3OwVe15CByvpRw
	nkdA+s+/mGPdvQhnWYOqRYQHdU1NG1Es7WoRznlYl+mZSszkbC+73vx4ukBSSGrG
	0qb8Nju1lWFSlFhaH/OoyQB2bVDGa2OuNosIXJU2xvVJilxvJzGvrieuaTiU2v7y
	aFeQ33DTlcyO2nLPZbvYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760759743; x=1760846143; bh=O
	1OWHiw1ISX/XiaSgOMO5lUblMBfevYTme7V5wEqPbA=; b=JFsiRHb+IeRAUhjTY
	sbnKSLsbLEhv0fiIdBUBDTgxQPOoGK3gCqiuOt9BY1s+g56ZGk5OWxZRpLNUzkxI
	hxKYYjIeNp7V+n2Ngz5ExKt5z8Tt7Nfcfn4HVxvAeBAlLw63Dnls01XxBOpU1mkF
	0G6AVOsAgeY4qthXgKf0I6+MoXW7gCGwjwSrYMdGagbbP1pfkfQ3nx/VKi3P6lgc
	pFOA/6p3ePKiM8laGWj7m587f7gMGoAwUjEUo1/yC0dp0snbr0mKgiNKR7eCdDl8
	Wx+MrzD8mQANRvBu+qXH0oc4A+2NSqoLS41okGwZycaffb3By7A+TLgFdJmMJkfd
	488lw==
X-ME-Sender: <xms:vw_zaDzOvuXp2ek6C9cpUQilY3HGXREMu-I4_EyR5yUYnK-sXTrEWQ>
    <xme:vw_zaLY4aXFPe0mcI4tHNNvcFXLzPpdfg20K7peBJoYHbgbCrgDUEs1GOESe7qmcI
    yTHQL0J-bzkhaKQPftaeN3cjigRCYUNY8kCSPfViwqz0242XlJuFbs>
X-ME-Received: <xmr:vw_zaFSzW1ypC7AkJJ1NELS70vq3ssrqC2j9SCfz3FqT8h-T4T7S13gR3sSfHwt2LrDDTqyPrKxFix_0e2wa8BGR8kNxabSAkxyTJRrQp5i82A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgjeeuvd
    fguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vw_zaFyTx0JIo5jdl5RBzMB4zRG_pFRguEGXuB76VuEiNMVWH9y4og>
    <xmx:vw_zaP1zGMz1qDUBO2yAZr4UlrLnyQCXsuBJ5HY8rLeS3bjb9iS7VQ>
    <xmx:vw_zaL6--gqqUhoxBVHDjgspuC6oMbvU5-kqiXZpHsBySg11-6YDtg>
    <xmx:vw_zaKUgizwdbv9ooDpJUMbCpcgizXDXFHZQeTptpD3HkXA5ML07dw>
    <xmx:vw_zaIWeZg7iABT5hco4kiBBO2J8tIWREP1L4_quauW97XwdsHfEuOhu>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 23:55:42 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 4/4] ALSA: firewire-tascam: reserve resources for transferred isochronous packets at S400
Date: Sat, 18 Oct 2025 12:55:32 +0900
Message-ID: <20251018035532.287124-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018035532.287124-1-o-takashi@sakamocchi.jp>
References: <20251018035532.287124-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TASCAM FW-1884/FW-1804/FW-1082 have a quirk that they often freeze when
receiving isochronous packets at S400. This behaviour is suppressed by a
new quirk flag added in Linux FireWire core to restrict maximum speed.
Consequently both of the asynchronous transactions and isochronous
transmissions are done at S200. However, the device still transfers
isochronous packet at S400, and the way to indicate the transmission
speed is not cleared yet.

This commit correctly reserves isochronous resources for the transferred
packet stream at S400. As a beneficial side effect, the pair of
isochronous transmissions for FW-1884 fits within the bandwidth capacity
of the bus.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 9c8fddd7dee1..4ecd151a46c1 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -282,20 +282,22 @@ static int keep_resources(struct snd_tscm *tscm, unsigned int rate,
 			  struct amdtp_stream *stream)
 {
 	struct fw_iso_resources *resources;
+	int speed;
 	int err;
 
-	if (stream == &tscm->tx_stream)
+	if (stream == &tscm->tx_stream) {
 		resources = &tscm->tx_resources;
-	else
+		speed = fw_parent_device(tscm->unit)->max_speed;
+	} else {
 		resources = &tscm->rx_resources;
+		speed = SCODE_400;
+	}
 
 	err = amdtp_tscm_set_parameters(stream, rate);
 	if (err < 0)
 		return err;
 
-	return fw_iso_resources_allocate(resources,
-				amdtp_stream_get_max_payload(stream),
-				fw_parent_device(tscm->unit)->max_speed);
+	return fw_iso_resources_allocate(resources, amdtp_stream_get_max_payload(stream), speed);
 }
 
 static int init_stream(struct snd_tscm *tscm, struct amdtp_stream *s)
@@ -455,7 +457,6 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 	}
 
 	if (!amdtp_stream_running(&tscm->rx_stream)) {
-		int spd = fw_parent_device(tscm->unit)->max_speed;
 		unsigned int tx_init_skip_cycles;
 
 		err = set_stream_formats(tscm, rate);
@@ -466,13 +467,13 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 		if (err < 0)
 			goto error;
 
-		err = amdtp_domain_add_stream(&tscm->domain, &tscm->rx_stream,
-					      tscm->rx_resources.channel, spd);
+		err = amdtp_domain_add_stream(&tscm->domain, &tscm->rx_stream, tscm->rx_resources.channel,
+					      fw_parent_device(tscm->unit)->max_speed);
 		if (err < 0)
 			goto error;
 
-		err = amdtp_domain_add_stream(&tscm->domain, &tscm->tx_stream,
-					      tscm->tx_resources.channel, spd);
+		err = amdtp_domain_add_stream(&tscm->domain, &tscm->tx_stream, tscm->tx_resources.channel,
+					      SCODE_400);
 		if (err < 0)
 			goto error;
 
-- 
2.51.0


