Return-Path: <linux-kernel+bounces-829680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EE2B979E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792094A852C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F330EF96;
	Tue, 23 Sep 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fBVazmih"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445930CDBA;
	Tue, 23 Sep 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664110; cv=none; b=Y2Q3ch9mjM/0E2EO+AIaVgHOI8eBI5HseES6yMK/n7zI87YuznM7hMYPdiWJq8iMgZXhPnKpR9FdqEOI343YtLIRlhuDb5zAOuLPG6AwJ2ljzDcQMkMofM7dGBUxFfFyCQMLvm5XmjPDDMdJrnApluB82M4XOM8aBW1pDBNHeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664110; c=relaxed/simple;
	bh=8RyHqI6cIPJR1OER78OMZRNYM6DeQoldFJDNL6Qb+RA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDkx8KFXDSecIEMYOcdHE+uH3hxDjDXtjtU2U8RTp7ciP4Z574HOkdS/17LandGRR4o3G1FTbq/q97idv0nmpWDESaiE/DRmDj5AImv2vVeYvFL531IaibYA84btKBMqP8toTlx92oqgYZ0owVjpbvxWOTiNhjPF6yrvsLBAEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fBVazmih; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664101; x=1759268901; i=w_armin@gmx.de;
	bh=EC4uCeLwZzCBzNXtcElYl6me9giVkSk4y/46HVikdLM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fBVazmihJ/xXq/0G9YzrWpVeU8cHHk/sQAl5F0aa4xtHqDTm0+zHj0avoX3MKKeV
	 g9MTLBqpih+UKqfmzL1DFu+hCaDxJ9lwRj6novyK9GqOICwG5WpHH/ZY7Td0w1rSe
	 KISMKkI/No67OkyQAwVj5tH7dl2C7sjlFEET7HuUDrpkFYWdL8JvtbwZS3a79ywIn
	 qsAed7GUrxkf9h8akVVRvuIk3iCTDFnA7cLQJiE+GFwHhMdv5d6VsUSypK/AT2MW/
	 Tyi4vPZAs6IyuC9A4JUMVYlrtDaCBFJRZMRhJAtUhlkglemovJI2JZK9XinPchDYl
	 re4aRQglEZgijHCytQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Ma24y-1up9n647Ma-00WZSz; Tue, 23 Sep 2025 23:48:21 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] platform/x86: acer-wmi: Add fan control support
Date: Tue, 23 Sep 2025 23:48:10 +0200
Message-Id: <20250923214814.325808-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RoHt0zKDXhNT/SaapCB3nSwEcK+FvARpsRv/W4BiC9r/gwDUfDi
 jMoa9xbP9hhZJRmQz/jWZu6E91EaKTf5BR7v2hYCqQZEgj8SQZ/oog3kxJarnEihiJGeTcY
 nL7PSFhen3zQWi+PknvmzsmGbQoes5FNExGTsU6AW2jIo/K1PsGpUbgl++/m9xwGEKgQI2p
 AzyVVt6WO7Tnr37ESuyKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:enbFqTq6b/o=;pSO3E+gVNg8brwrviDkefKDZUs8
 ypf1bUZ31j4Egeqx4qFp+6B3GvPL9VbXUjmGvVkuU8/+nvKNfURacoxY6W+rkqGzXvTNDrD/4
 aL/qCBIm43l2pqgVtXsKX0qKApwI1/Jo1QJwE2oWivbyNFAdj69/8lQteukfsHoQsD4OrnmsC
 3pnH+e4gc+uVsyUK4I9hAlHihlzym4AIRLaW8VRqmpoy3+wG/q+hknNrg7ygf/F7D9+90gGov
 qao5UQsxsHcgG8kTe0aKZ80HUWK/QORyeeA39wby1gtQ09XJki6oELGa8Vq2dThWzW43A2rRn
 pzOLnRzGW8D4DKvV6Y4YHljTIllyhRazx//irXz0ER25zhtR5w6maCak838M3SwJxZnTPZkG1
 /ksbd7A9TyZbAxsgBa4mf1FRw7BVyR+GOJ+/QGhTH1RgeeCI4EkPDMypHGP20BK2LDN5xdnvz
 XDbpHGjeGeizYeSwVuv5Le91040XP/YoN49iMElgghkvYKO+VBIU7AlI4e4A+gTjGCUVOeoMI
 JSmQuKv9B2dpWH1zHWQTqHX0nAuUIFFimC2G5NXo1PIfSH+tT8TSFmd8UjL/0lJScIYEr4Kkf
 hF4FTXJ5WMt9ckW6uffGWzDCQTVhb0xE9LRST4qxClkUM3W6Yt8S5IFmWhDyWX/seGXCcmby0
 ne4l1s9ArpNwk0O/511Rnad2XnYNQu7Z1nX6EUiB8PZuuzNGk5zjA0lP9/Yd9Nn0QQBh6pn9t
 xoCTHNyhi2dk3zVDguNHqlIalePPjolcd4gfYpU+RknMF6uzWm3GFJS19MpPO+Y0ySVuaWIX9
 rRAOTzbu7km8JoigkG42R57Fx08++e/wgoxUptQaMGCeDKwJ0AYp7VLNM5ChLJsfS9mIgnDUh
 4cwZR/W/md24L2QKvTtehFqKdka2Uu/N68LChoFCQJtUM8UUN3OBy1DHnaPuxemoMJ8amTIzM
 6WD68p66/dvvL9pejd5xulbOvCe+aeKNViyRRSIotmI7HYrXxk++3QQch5cKkuStlSI7mRz9F
 jNJWMS2EqaacDlr2YEBDt5FZFEYKQSykRxHTNjOYVLW8159GoA3Jj72dq8Q0+c7X4CCJNIUVr
 RRjizAgto9cN+dlbSULslLvCcv88LBjNjMk32tBTLFPueNa1Nzyc1cF5ES9ni2nKnyPCKeOZ/
 CznOuDgeaN9ZEfojJhM1bamdZEbQKOohrZx6ocPA0hiCrNM+ne/y6XxKc5bHBfhq/RzQ7LLOl
 LOL0I3Nh4tkN8yHtI9tBtNKWl/idtA7NqCzUeAz5eeNgZnf0XOUT17pFYBf/5oR3bup9Vmlv4
 cnwuG+n2wRhnEP6pTupRyF3Zdg9shN1qYf+lTWCeyPncNtU0WpO52iIlCLcWKpRRAxpKhKaWm
 Fi1Iv0cw2ilIChb2pSWe5W65Gq9db49atiBeTFcDCQ9Qryy7zgjUiPT8Q7QpnmmldVmbHNshY
 Hs0IQpBx4NXIub7AszmMT8cmsLkI73dCSLWfZsvlqnoK8He1ZxyT12VDaJTalpz3dCrfqURVs
 /EXajNoYhuQzrLy/mCCIth1xqDwr4xXsyxysGAU9HLmA/FYUrNhpxWsmBkdtXAsnNrZlCx5u7
 ZVVK7WVmRFHEtq12gKtCwZ8One2cf6EikRh+HPK1wEW8rYuCM3e18HJKoj8hD+ACUYimFPRTF
 8xrvV3MCwjf8vRDqybquJn19wRLs6bk/bL5eXYwWIVnnIPt9ZfO/uv0xRdes+ZlgW9D5+zLKh
 d1pqqtGSYpkZ/cOw88H22mcsica+noSZaOtX8ljiBu/Nt70rF6I1FYABVSt1bc+kiUVVjD2wl
 R0t0qsejacr6FNQTXnOaMMSKKRIqzURmp+YQ2uUvqkNYg3x4sCvZh9NR4OulPTiGfW1EZ7lbK
 n8PVzzRl1eBDdxGHLKr6qu6s0n06xIyweMMO/nxy1npxKOOcJpzNphc5gskTDj4v/ZE75Fg9a
 sTIoIcpzYs1suKQXm7DDDW3GqpSAdfB+ka+XHrppXpOFWAiLIIBUWz9eauJTQztjX0wjdzwKQ
 rFmWBxzPK2T6NzAgq/8Uckgdh4/3/NpuVxXjEjXRxpbfSSwbaPK37N7ibBRkfSOlBiAeMeVk6
 +x7Lae5ctAa4pb6LTOyo/kdFcAVDRkuJx6dR+2Bl0irL/XxgPLeCQe0BOLGV/L+uMvdVgYfgP
 pibMOy2DIcrGnytrDiyd0B3y+TspWigMxDN3iTwB7fFxuN6ZI0zcL5sE2Wu5LWeDf18+mDPeY
 PTep/5QJ+S2Pdn+TYKUPIcOG9KyOKJQFEkDhMWLrDkZ0Gf9F0LTcPfdiwRthqF8oxlSAnweuv
 m3ePpWuUWvIDQItwMRjqJqDPuciBIHyobetK8je9PZG5TazcoC/37TtTk+anOiBasTvxx2mpu
 Z4X2fFD11OukXty6quSt0+E5D5kxUgOOPDdyMOa8XaCkbsyqBa6j/SMmQANicRdKiM2CNTBp1
 N7GxMEaPLOBGKuw4aPTlC7zvv+xSe2nLgPKdxwDEqHQG1mt/qcCI/TCYrZdOF62otDUOhGi5J
 T0LrOd6GlCrZQBD4oMrKcEBq0RoDwSTRXIUJxE535nzADWj5j9OISKOaLK70KjZCniTcm6w1V
 t14qIR9uFpntD+40LZVsKUkGUWpdDKyM3gxa/tBNkk6EbqjV+wG+nVgsxw6TZJjpT8mrQ0Y9Q
 GcHljVGKeVRIC0JFTepIw+Je3PcUmN1hK0NXUbWUQwzDrI1avebyxpVeqnOXVoVOVio1tJfWZ
 jiG+QCngW5U+y90LWbjLF78u1uBMq2xDkhAOAlDVNjwopUBPXISe6fWn8b10BYszf2pvmPi5i
 n3CZ8Cl0rfUIaP2IftDEgSUKKEW+0q8JeO+jOnuonHwm/Wwbf6GZbWBi6FWw2RWQ2xbk4jL91
 zSxW94OM4CUMKAk9nKEjpkv+aIoFjiRrFFnvqrT3hU1MJhXvq3Jj+gVOBN0OAMRRmloCrbyE9
 vq+zyaJs5Ei8wL7DKv0kQUJFx6ZZDqeII1Ojy+Bc+OlUQduvXox1E73R5PVz3ZdY3LPeXxrLq
 h65wU7cwR+6MHcwEGP+h+nc1BmCReXJaQ2H59tM8ytDFA+gOtKOOfsKmWWiWNmrw+DkK4NV3W
 qFxN1iYv5I2fNaXLlNbmTiNvVUeTxL7CA0IW6Fuyn4teI3NNGttot1/H3UVUNBmU0HMLJJ4BU
 VJMcno+MfpO6ZlRlos5WVGbqKm5NFtisc+5MiT/UB2JwMokFj9FvrAijZxr/NsksAUQN+7CRg
 sjweY4k9zpMNLpJZXI2Lci67qdmiqFK8z1tAReVsw30dHMOBM5ItuS+r0H0+dpfNWZpmNmTa8
 raEXDRKcp42wLerEmhuYsNSWKwrv+2DkjpWaLAMiBd7slapqvHieai9QHqzHXVkzc0K57DNCw
 jJbzpsOayC6vjSXdWNpnUoRGbtzmDONLyAWMev4rqVjRw96HQPeImyWvpkeufAqGG/kbASM9g
 FenJpQKiOtXyJ2laS7MK0qPuOYk2AzncdVn5KkX5Clf4LrgiS4nuXKCHdjKPmHOOEcqH6HXZN
 SoqKp6ptydczFLfpnaG08rv9fxsE1UXTajuTucGp/kIAXCj14y38rCtd+95ruYs01ur1gjwWi
 CyMH6HxFK3xqK1NX0eoSuqcRJMV1K3jIfqC6UHYyMpaX5T1L0G7qWEagBLyPXWsIokpnL/6FK
 of653dyEjmxq2bxUArEKy90EqT2Dkxocc9SkxNiXcEK5cniFH9D0zxurlx3di68IztfOMXonv
 zS2pwxyL4qdz4iwxhPMyXgg60Xla5WPBh42AV6mS3EHOPsLwKGO7RutptRjQdT59wJUwu9wjV
 aD8bVZHNt+weykRCU+TAFE6g4H4qvHSUs7PtS9XRdObcpirEjMqgsZnikWs6cJKkBiu8xKWOc
 ExGcZICgCB9EEMCh0W/k/sJhNOKMrzwkG8lsnccXQuDk0VTyAAplgJdPJjwiWmvO7WN77e3Ir
 y/pDEYWLDdqx5eIVYO2IiI5/hPuBzCbybPg0DDIOQlNmiP+eLsCMP50i3+wfrvECRjOSpwjNN
 ErllLFUmfWN+d9O8Y0yaG5M4VqiyGw6Rtyex7GOYqxiR94+WAZfxSKQvlJLwqEa8wRf6ci6f2
 UgI//+Kwn/RdX2WA8I8msxAm9NgEbp8mmTe9mIiIDbKOVrh3lP0ML/f1ERz1B9yU2oXdxLYpN
 ay7O8YxmF9Bs9/3lVmFDOkfPp/2cEwTU0MB2eM5bauLm1umx1xqVPk2NAIj8ON3Tnk/tIUknt
 LGyAsNyNQyhh5QsipIu4FBl5zNd/ogHeI1kdgbsPasIx5ehbzJbnM7gDgDdwi6tzNyXdVnec9
 b0fe5L0CZ/z2QEXy9uOmpEZUL0Lul18/F+OP0fI7uMrPnFCo6SK4qMDifVMI34j9e0gTwT6Mu
 bOQ8igtns7/MzIxjSElrYy6EiKjsvJSHuROPSacVLyh9DVxFjbEiUr6/Zo6G2al5i28hhHpKi
 rtAeBAQA8pPh0xMsozAwIkP6Y2FCPh9wRBfWVxLq7JMPY/xp68kZPOtOUVoiwmRHt4ma2LVXZ
 LGvHYaslnpwJM6KPbcB07JUCsg12lHppIM36MGHhEK5U5vvHM0caoXWXy7YLHdbl3CgEwcOp8
 8rA0kfLTkCMsiNy43KcpG/7wuFSy7To0AbdACGwJd9s32cGhVsZuagdNZgeGrAOo5HHQjZKl8
 clxY5M82HYZe6arvcQz3fuR7d5mr

This patch series aims to add fan control support to the acer-wmi
driver. The patches are compile-tested only and need to be tested
on real hardware to verify that they actually work.

I CCed three users who requested support for this feature. I would be
very happy if one of you could test those patches and report back.

Changes since RFC v2:
- improve error handling when setting fan behavior
- Add Reviewed-by tags
- whitelist PHN16-72

Changes since RFC v1:
- remove duplicate include and replace hwmon_pwm_mode with
  hwmon_pwm_enable in second patch

Armin Wolf (4):
  platform/x86: acer-wmi: Fix setting of fan behavior
  platform/x86: acer-wmi: Add fan control support
  platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
  platform/x86: acer-wmi: Add support for PHN16-72

 drivers/platform/x86/acer-wmi.c | 309 +++++++++++++++++++++++++++++---
 1 file changed, 284 insertions(+), 25 deletions(-)

=2D-=20
2.39.5


