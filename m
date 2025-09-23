Return-Path: <linux-kernel+bounces-829692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85480B97A43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695EF1AE0F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751930FC2D;
	Tue, 23 Sep 2025 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mPiPr4Uu"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482330EF72;
	Tue, 23 Sep 2025 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664340; cv=none; b=fZt18awar2xJaTcdwWWNiwjVP8AqV5Xx/olsLbbAxsibcv7SyJl4iPtX43KDc4gBmcJQhkP0IPhgGfl+ET6vdzNvN7d3Ru9U8UqFIGdJz8lRFAaaIXYZaSoRgS2IlOtgI6AUxkZunL8o/St5EHax7sQi6MHJslVYwrTxiE2bCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664340; c=relaxed/simple;
	bh=qvQGyeXD25pcPtGrlV6UMDE0CrKEvSv/nJxrfrMQafU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZB34Zq9KX1xkmIGklZpekUB/QlTKdITuOB1F3gSRq6B7hqoFskD/fpa5qk/JVD0P8eozKrUj2a9z7CydY4En8hvWVIoseHbmP+fsCZoes/nT2bTF/E0+ojyGblODDLPBT4l30S7TFBscf5x56sNCedLQrWEpgetxtn5w/L2AyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mPiPr4Uu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664332; x=1759269132; i=w_armin@gmx.de;
	bh=Ac+InPDx4nVpZiAjy4bXI9gssoAB9nb3eaQwGYXYkyI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mPiPr4Uu5+0pww3Hr7lTEA7j/2bEFbCZidDz5/yJGgaU9kPySYRx+33m/023ZVit
	 4Lc5aUPySeLct5hgNgzDSjnR/NPD4nC2tvhCpMTceL6pcNAT8bNALX6TYUPhNxzNz
	 adGBVhLktY8Q88A3bwaH50mrmLlCWEO1jD4HOTqezey3f5ASEvIAfAsxfkgETH1lZ
	 AW0cKtS5UB51tvlrM7eApQeVibTEmgZYl+pirCjtWoNB0482lDZ6GJtdbJZCZnW19
	 MhgBkwEZ7MUAqA3y5R3Pes4WCCqCrP6zCLbtvB0SOBzLO3RzsfqzXPKAF272GPLhN
	 XAOeHePj6B+A1DgxPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MgvvJ-1uQjBZ0ejN-00jwLM; Tue, 23 Sep 2025 23:52:12 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] platform/x86: acer-wmi: Add fan control support
Date: Tue, 23 Sep 2025 23:52:01 +0200
Message-Id: <20250923215205.326367-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K/ZRqa+je7kE+7jpFbfpRnFaE20PLb4JJDwPzfMfd7dEm27Zq3c
 FQ7Lt9Ll+Z8IBdpZu+4gCc8EWMZFlrTURRJcECLil8DMZ8YT17NcTYxAqFjnBHoar3wuzOT
 bjSnakXliBbzlk0CJgQUDB773g04wSjdm690Bm3PRqlHi2D1C3XRd1bsLVNHk8KTfNkTMsJ
 BhK+oGXKdABGih3tzUUeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eq8fa5Wu1ds=;OkM0YSInQKXlzXCB3v4NTLgyEbB
 yYMdaRSuQ8VBQij8xt0ePfTNGv2p+sv7bj5hKuQ3tDVje58gv3LFaTilOPyaP5pzcpd72EUdM
 2aFL02mTgjYwi6TwdxNFrm/X2zwLSDd8sD914pJboIw5Qq7KI6GHpSoXWT098natAX1MJTGgl
 1vP/lrmsQm6to6EJXJANZurIdYeMwFmXcZngkFTHuhpQGvF/F9u+x+JHqKa3deCIp1dbUHMtP
 TSDk17uYFuHR/zsrVz4eYwQ5aTYIugycjFu8QF1Tr4xF94fb0m+K7uu1oH/vDIPvCOQa8xBwX
 b093z0V5DB/Ikz9+PEeKZYBbGwGg/0bO71uU0Vc6hTsR/s20K3JJPr+UvtcIWihjJGYlQMvOl
 wGXZIsaN/QW0Fg40BazlOj9+0gFTrLOhbmBZKTkA77rZir2isZYip2ial0W1WQZyAMhnY1Y0V
 U3iHTlY2G+zU6XYJWQ4+0F9xr5QgUhjcMOtFcm3cYwZpDH8dh9JSGiItS65OSVezyDSknkuFL
 5D7o4Zd4ee0y2NZoQvmodLz04O77NC5SadAGR92i7Y+HNCpxKS+fvJEMX3/sulCF9QT/oEka9
 P1rnO+vc+MTHhSFLot1p7fjo5qohX5gtLsCjw1JhbIywa9MaU5hRTbOho7aUvuouY44GzOtWe
 yYKARj0XejOdwWWdZlEnsmQWjwkY80D0OLEP7gMcH9pLeXQAaL5ngUZILCFamijLjAn70F4yw
 v0R+bHuORr4QTtNklRm/9hjnj39PijLrEbQW/4394WtB8yB/3ibV7avBYchQqk35l7HQbjoyE
 T+7GD0wBZMlKGB44bG9fkw/KM7599a0E+lS+3ezTwBUqEPic1+suJWNH7u2cl5H6SIEZXTZB6
 IfS/mJOTvf0tDxPRyLsFGQ1LwU/nxIBsK391BvMrugm+UfKUL4DMjooIKQBq0rWosdp5oLx+v
 gxkVN2jV+65KUq3vyt5O40429eGwnUvWSTtYvBadZHL02xiCgJqTIoT4mR+fbMy6olI46DdKD
 COFNPmr40uXQG3tQ1cQkhEhxzsOQpk8ulop6+Du+73n5WjlVYLCZRX3Cw5buoWWwF1I4I8M04
 unWKGNf6oLXNHZDyEVQPZDbhabCO156dxoDi7T1C/8LjgDUHCDF6RN0bKkqWzzetGr4MQSZoY
 fCeQg4NWCF+fTPWzhKYAROzMpVO4gsXya0RpKOSm/WdIQSLa4gKSXbl99F9alU2bpjM/2P27Q
 X/m68CxUJ8GlzGQArp5VtRk3ckPXapw0S9ksD3dwsW2BicjYYVY5STO0IZyXqVs2DWHcPrbuB
 Qu7dhokc3WJBmeut6VX0Gh6T31pAH8eutXAxl65yfd/iCPUBR2Oy3qvig3sAyqfHhKIrs/YJF
 iBucRGBE4vvI19QKJJTppNv+UrjWrLPfidri3RRibbkRhSU5DxnLj9KWoDP/WWIUIHytdSY2S
 v/2K7wCpfggwWkOt2ruGcsQLxa1xbNXVdmXSTtL5sXJPtFaygXAc6HZ4pFe5rrjKMMfrbCKWH
 6jtEIU6JYqOzp73Q14zZQ7pUARptvhBTn180b74vAgbwPKVHYiZv+cS58uy6OFPUXNCDcLEpP
 iZLTPzs4H9jKbjEhU2bX7T9TQQ4PTnuA/HUaiTMtVdBBqndJhclLqNag48MRjPu/tDSfUlRTl
 DRR/m4xHLhQQNQY+LUhLrfphM1RGOhwdM58A36v+D7Dy9phdEq2tUxOc+tupSYh2/+0HR/hQT
 Rvbwy+0mGCfqvvjtM9EOir5AM+mWLl/DHL2hCBjaCPKN3FTAqwmR0GiBqIjW4T9CRggh2JNZ/
 MVdangi6+VYfQK65HwiO4XicWx1/YaxiAG6MWMvjRRDBSl97KbT8VxruP92nL20qdgkhWd8fg
 41O3gx9uJ05uPoLnjmMJHoLksYRG9ETi78TTSHRBEJIfCU/mULdKapPUi8wp9foXNERabFHsR
 Ts6GtFVBtOerKrwSTwgpKDEJ/ytvTMB9jO69g6gHUpWtlnPoVB5fnoyuoSgbyMItvJ1xpD+SP
 x9dmRPtIhEQ9Lms7LhEOMk5H1LmYjCX2YYMk5plVw4JjJ900fPflCwzREoaktH+PxvtvUP9Oi
 McuT2Rmn3XaM8V+t9cisO3Jjuzzk/qWghfgivwczSr6QNYav3nReaquTCDfWQ3fUqy5Wc6dtr
 Bhj0ZdeC23ureYy3O7H8u48uQFTC3ib3FrM1hDsaE/kN3wW8jL8cDvwc97qqrES30p46RdIu+
 PlfsS6irpZGku+tKO+QUsxrjlV8M7WvcABBjAGn+hn0F/lU0aI8citHDpY2r/v6M/tvzXalVa
 0yYRHimupyPyfpuRejPhbseIE2rzWfazOMI5690NkIUqdT9wo5z2ljGleyvy8H4Wyqup9myBY
 HbTATQiL3/qNfdxP/huHlzpASa99WvqlOPChEBhL2LgxUU5QVMOFKP90lN+P6V3Iu7C4Tfl3Z
 e7I9w6zSw/Ms9fFUNcKxVjg+JTSfI2O1Hed7rWbcvZcqHydorXD1B6u7ykG359EM99dw833Xw
 B6/2PZfwc/K9qt8j30Cs9eOdtcC74c+pTkbd3H8DyrKkgA/i/+frRXytIDYau3FN3Jex/vrdu
 STyO2DvX3H/v6/FjtO1Gi/bjtoALHjZcX5yNYAHcYoSJiZ3W4qJ0VzxgrAQtlCDIreyRsCMtS
 Or9RzQy7p33zyyXvrXY7nx7RD/TazygjbJnRo6GLb0BqTUeFerjKMTOthTL8Nd8XQEjDbx24j
 BmdljQqrRd5OCmiPgcazT5ei9oD/RLjCN7VrmOe5bQbsxBwTwcGoQnzhmZlHb/GuA4NEavF60
 KIzFugZjzZe22dftN6mC3sRvXbd1q0MXvmukvSXO1zu9vTiHg8tAZjnsxegbxgcT/Zm1KiSSq
 V1940MmKQOo9sjQqtdijsGpKB2mNtxCzAcdlfd7FLEY+bGMIX9aJA6GidxJzxrTccwA1tebta
 z34f/r5Mku5XMA86N9uSTxKu1sYrlZdhKJSgq6yyrpzRShwp0ae1wJZZV0LyrrRhmoFlgVfnQ
 QDIh0ikPIy4QkOfvgTi5PHqWypEgGFxvEZ08sLFCwrcExqoudhxU0vTjyDOlsYOTX4F3ta9d+
 qs5ZrAfqfZtWXcYZ0SjFOiFjHTYUiNSv5qXhUXOpTBbEcKmiawkRgidZ9Y1T9659KRmsX1JLB
 wkjLDvTBmdpaKw3ZhLtN99gh5ds8taEgLlHlK+XI4eDu99SEdY+FaKnstMVqC5gnZ8KWMMJKE
 zlmq4bAByi0e4DOU90Y03qGpqscOR3Bv52OgXEjY879MhI4Ew01aDbjtXeHqCICXp3TCWL/Sr
 VEj34EqYuYfk4XAeF6W4WUSgPHbzkhiIYoBr2PNdM2nrtrEyHMSEQB84IWIGB+zCIjqZ4f/cf
 qOyVqTZ+0KcSfWlAT1tnACvv47txz6lMbRpNh8bP3RJyeuJWxuu40+Zn0cQIFHOLjmo/R32ux
 5p+K2sA/6nFDbgo4G8aA8pSSBDkqqBZBw1HW5gA+Y6vQHam+5QSRee3Z1Co7pMHUf8aqoKiOV
 laNT0CxWXXkpWOicUSKTwtfnSB66iG9ztiOh0KZdPCyY7DsD5Qi53+6cfJQrUUyT3IrVoVp87
 V1SLtBZoKKD/33if/3puZFcVSbkHjFZ9SQCuRGTLGjmZEbNALq2A8H4ikYq8Fi3J6Ehucwha1
 HxaE9Pz+SOje+cu+BBXqc4RxbHGhXaVPzytpXWQ+Z0ThUBkITcrjnnv2OUawZB3jQ7DvvOIbH
 Owy4i6buM4hZeVGjvIFFZ3ta7AnCbwX9XzL1DA7Qlk84YIm7yl7ymWYhNXyU1h0oPYvXLGcu9
 w86IStIRH7u2BoxS1jl1mSHSJi6/8KxgIFCMfzoygPF5OlzEv5/heN5rOp70CzScygWRbtgvE
 aiLFwb4D509GvhnvVVv2d9C4AkKNXyJLHEMERnKn12Il9P7R/RUeGH2VOSPpGVOXE2De5Gsbp
 sIcT/B296cfyw51ipfv3SU8GzgTqL3HcDlJ0ABy4A076HnxHmn6nqcX/NDgHtcA1RqfFn3+Pn
 wYvZ0wN6Z1+KXhtcwjUolzSOofCfZe8AUSt5HseV1J1Xeg+UI19DwFKhFJAMBSTwoOrs2jJ4l
 CpL1mh5TqdraSjSQwlFfx5ruFqoQ9d1C5NS6ziSouMjnvUlwUSUyTnbj54tXUBQahBPnC61ev
 /fHfDN9CaeFQZ7pIXh+DdMYMaJTLLDA7dxJa0NsMwRx820j4MEnsl6M4roGzChvryurjKWEnG
 mC/TFgvlfjRsq1z2MgdoAQeGoPmABU4hR1iebs7Ta6QqHgK9BGoivmKjNsB6lMzepIAwuL9CC
 4mCMtiqBzFHIGJnVeZD9btdRm9ZMBGhsY6ZPQjQPhG5wxZ/bZy7s0e0VAjg4KwS7evldJf0Fc
 m/E2A0dQdIZ7viRN67tnF87AOX71w4xhldMsZh/ATiVncIXgvsHFig6M/JdNE9fTL4tQhado9
 zrL02x8NlIgXXx0bwiQutMkBSgOIeEcUpMhvbAS2ORzlqjJp2SEb+qdupaLm8NShm1mQFiWM9
 bfandRv/QjbvsfuZJTRwsDCcjfzGPgBuhldzuyAbdm/1c1A54eolIPuLPaCjl23ZtxasBEIuG
 hfUHPuDMTY5dmM75+ot2i6+Zce09FB6j2fWhzDPW6jzge3UmwO/7XSr/DIg+4aHb/qnkVoaxW
 uOjmpJJzsQFKtI5GY5kdMZCzzgjd

This patch series aims to add fan control support to the acer-wmi
driver. The patches are compile-tested only and need to be tested
on real hardware to verify that they actually work.

I CCed three users who requested support for this feature. I would be
very happy if one of you could test those patches and report back.

Changes since v1:
- remove unnecessary blank line

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

 drivers/platform/x86/acer-wmi.c | 308 +++++++++++++++++++++++++++++---
 1 file changed, 283 insertions(+), 25 deletions(-)

=2D-=20
2.39.5


