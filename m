Return-Path: <linux-kernel+bounces-780494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC5EB302AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C6E17F034
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66C3469EE;
	Thu, 21 Aug 2025 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aFAOahdz"
Received: from sonic311-21.consmr.mail.sg3.yahoo.com (sonic311-21.consmr.mail.sg3.yahoo.com [106.10.244.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A56BFCE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803490; cv=none; b=Zs7XK24GzZNrKoVFPPR6poi/7WmXY1E59EPxZpRYnQx0S3JNpftBTJfcGWqBuyKItocnOsMcm4+oLj7R9n6JBHuJXOlZNtMTCRbhMPG0cE4DKclIzQwJQfR2WpKDJ/Sjgovt1SXWczRb8BjAmcIWFi2LzjwqyP6pSX33D3QPNo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803490; c=relaxed/simple;
	bh=79qMtTR4pCr7m4hgzi1TMnj2YF1DzyvB2hWRPAcN4nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ8xOnAWCi/Idv0KxYr3Ef72WaF+0RR6PWGdPmhKwWKbb9CHjSm4Y8EXE02IafutHlBnBwMdgU3GaLH2s3iwRH+o2HjQ8CgDCtgr9m+631gucJySzRZaoqXmIMl3mkolK+MrmFV1IGik0JofsVU8cEA9i9D99pjzZBbnjfAj9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aFAOahdz; arc=none smtp.client-ip=106.10.244.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755803486; bh=79qMtTR4pCr7m4hgzi1TMnj2YF1DzyvB2hWRPAcN4nQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aFAOahdz9+ZrXwLvq4YssNBcD66BBzL0GSUmR16FROpllHSArHmIRRqdpa1ZhYj4Jn8/6P46q7nOGdy8dKmUy6IPMckW8RB6VihJdBXcKZ93uMNPKpIYxCFS6qtH+dY9qUSxtdD4mwQoeoXdou0dbZekPoq1B9kqcy0ylC8QuhKt3H+jMpwCqwqVXIeaTTVUGX2TR7BnnomoyzOkMgk73rcwcCwB3+PlOkSX9lGur5izSTbNJNsGrzwAIlnXdMZsBktu3+hRdVLBmTG7r1lTXtQf6KNgIZ8yqzNrnaUC6hSIFJXnCzSN2YV2LzJhuy3YMRoqiogINgipQzArAi+O9Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755803486; bh=iKVvppsSsgI9xWSFQ3ND8FR8LOYm8rJg6QVehQmI7hE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SrQrh8JOPTfc/Wg2WAVc8wCprZh/exIj+LdGIWzGMkKgmNui8M7eOqcKpSLDMNzD1dg/ent6TtLNQEPUDtJMO7CyxHICh3ZWa2J01nN2K+aHCwec/typrRYCkwcYJwBmsuHtVTlqHDLYNDPJ96WvoUV4l/QaI4KC53jYisfiFma921o6Cswe5RPyyCSyr74sHYRdRy6nd6z6OLsEc9mjmGozwO+lRmlPSULKQmgUuKT0v19nWo3U1xTVz3RETUpvP7+DlwAeOWdrKOfopzPl6xXCY1x3GMKwhL6gsOFD3LVQ1ED4hvuvgyhVcS26Bu4HOkBf9X2Vj4w7Q2j/V/KP7w==
X-YMail-OSG: TGkLaP4VM1nLSGOtAxOAS8DHyIaqeUWcqNZOPGYGG0qgGc88Piy6.qOfB8krpn4
 90cTgZMSR4yOSsmNxBT.HafiRoj8pv38t.FJMAnNGxlaYJQjsiQgOdPFJo.jucGY95rwD4meJyW_
 _ICSRtIiwstQHuUft5rhAOkzLQMk3p2C4bRxHk2GXQktP5s_eYkuFEgToAGnPmFM4QYzzfjpPwbL
 LKqACYkAQWTHaH86ooHOoa7ewdi_B4JvOBmxlAx7No5ZrbrqP2YegiS39Zxx67zFiJnbvxZpsCRh
 Ka0xxrjZQGfA1sHpz2q70VKMpCZJHuVkk6_LI48NU9zXH_.mOA8AdzxohkfssObl.4mG5q7fsorX
 dY4pl8U5wWt8Ak81icHDxClNLnw9lMBFd_PL6j8Ii0AcJxN5woq.WxNSjzcgY5EM6qSiFQer32T2
 BU_TDi6v5xhsSMbyroX8CqZqHO5mnLB20rS2YTs2C0eoAK.XCX8p8Oyhz4z7crXmmEXb.1EckWA_
 RZ97d0l_0ylunFvLADeua.m5jmI2agmyIWV6BVpvdZ99i8daqStJWrIdDlZjgmC16VUMEEAE4Q2S
 SaLa_aIIy7eLlqHuWRn5yhWitVtfYRN94gCAYVyRBAyeJIneuCFsRXTDx21O_bcBi4kYbgWYQzv.
 P5ASZewYO6S.cmTHczJMz.T77PBxGi6DkTie5TydnbncrIjSO72AwgzHtdYyNhr7I5ObAaaO5ts4
 UJBCShAQnm6vg3PcpWV5TbiGlTBrV.RMLIgy87Ew3v_oe4rbSh1lnF4y3udBIsYjXjtVhizSdFDK
 tsRs4tOHcOUnuCOiU1sjBmix37lcrTCTFnaZbbtsKjj7HBovxc9AivUPC.wdTTp5RvExZJWR85q.
 PF1cAFesb9oBSco.BO6_CZcDNIwvyXPve1EPRokx9ONUitNyoDiZ9Z7yU4C38zmjXaJLvcE48AJF
 S7LEyTtfZ9u6O4Ck_MBcY0H0yLKt2VPceQ_Z4k59HNbGkTWFEGcdvnbET3TjCGhEeKLQVH3U6hsa
 v.GC94Xt3nbKnIYbY17eoPgMTqMTP1BmPX78g1otx2_SGi.atWRjOsiX6U4jOlDkya5e5GbMRJr8
 ouXiFrT4SYP76iPwAdagYQDpAs._Gjw450rsJFOkff_gQalXDQTA35gBc6tbbDFrTL_jhc5qwKAx
 28EjdroxkhlasGuc3dBZ5fN48UPBCt4lHTj5hfGfwTfL8QzjQemkyOLps1XRTGWROmuoRrM32TA7
 ND5o2z647VXd0v6A61k4G6j38pn0oQInKKbRzzxHMg.rK2nPyfb2cOo71V6ZCw5IOMmWeezaSoAQ
 qkCqjW7XKdp9h_eYUF56Qo41wikuKywBrd96WSjOC6K.4xvL69Sim8FU9B_kfrvWDAwG7HSStiEI
 IwfMqVQomTM.T6r6eslCdSkysJwmQdvc4y7HBUI2syg1_86iavOM1b0YSMWyoz9y89gVf6k8C0It
 eEZAWaVnO8GIStST1AyR2GrQdg66L.FJxxPI_FK8g1sTMdj3oDACjKJhqBxF_aANlhV54yRmSZ89
 mDNAtfsv2Mgxl9OBFjE7nU1jTXogGD8ZtUU.ECQR.r7L1lipScsUpl0ruQ_qAcgGlJK6EFW_wmBc
 _mEEaYjA_6zbwp1ZB4o5cMHatO9FKpKYoF8KL4ggG_JbNsp4j_Mu_dtJ1cwuV1gijA1NKNbrqE3q
 KGdWcOm6ABXRKyW3v0nNta_fspuOdraxvb.FnofKYMtJvCIC3Q6cUuRlrRZXh7iHkYyJEh3ZIPnt
 vKnob3ixMwGHJbjt_t37mqmU9uHoxC.rVcXvAKnddyO2VQPd2FllepKL5REbkcJO_cr8zZiTGGMR
 YHaJf_M9tj5jQ4JePF5DDojWWKmcnn0Dd.1Y87L6sqJba9BpNwFl6649i_iLbCbA1G8IdT5c0hrp
 FzphVREkqdLWHDJM9GzV77eEVovGPUHqNovpDEwjGNuvuKeuKSTkSoPIBI9x6dDf5Ub9zSvUEitI
 .3IzsmzCEoM.UpzTRIfHffnWDRxHy.6V4Bb6NSbaRcyLsFQZd0fWe.ayWaxvAcW_oUF68EjMVGnm
 58Sq0a5iBZD.S1YYYo1AuEYp4G9JIG.Dqhccs8njbCiK.DiPR43APsPHxrE_8vEndyNK5hxKBs3k
 59h1ujBOoZwhIgILrHa_GkbfviOod.z_hOtj1fyK4fHq85Z5KU30enyehPtZq4bhn_EbaIxdWN45
 dE1IskItp9eUX5_g.qI_qLRDsVWcmbdtOG_hLhyY1iyrpeN7sPH0JqpC1mu.H9Ih1tjuRdWHwPdi
 MA6htqxlmboKpzVMKkA--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 5ed3eba4-7b80-485b-9dff-9c2729790cd5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.sg3.yahoo.com with HTTP; Thu, 21 Aug 2025 19:11:26 +0000
Received: by hermes--production-ne1-9495dc4d7-dbtfw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d67fb2e8a117233158f28e86817b6c53;
          Thu, 21 Aug 2025 18:40:59 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: sumanth.gavini@yahoo.com
Cc: boqun.feng@gmail.com,
	clingutla@codeaurora.org,
	elavila@google.com,
	gregkh@linuxfoundation.org,
	jstultz@google.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	tglx@linutronix.de
Subject: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
Date: Thu, 21 Aug 2025 13:40:54 -0500
Message-ID: <20250821184055.1710759-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812161755.609600-1-sumanth.gavini@yahoo.com>
References: <20250812161755.609600-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

Just following up on my patch submitted with subject "Subject: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit".

Original message: https://lore.kernel.org/all/20250812161755.609600-1-sumanth.gavini@yahoo.com/

Would you have any feedback on this change? I'd be happy to address any comments or concerns.

This patch fixes this three bugs
1. https://syzkaller.appspot.com/bug?extid=5284a86a0b0a31ab266a
2. https://syzkaller.appspot.com/bug?extid=296695c8ae3c7da3d511
3. https://syzkaller.appspot.com/bug?extid=97f2ac670e5e7a3b48e4

Thank you for your time and consideration.

Regards,
Sumanth Gavini

