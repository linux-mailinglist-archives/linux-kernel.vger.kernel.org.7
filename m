Return-Path: <linux-kernel+bounces-877407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0729C1E0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532B6188F2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8829B77E;
	Thu, 30 Oct 2025 01:42:48 +0000 (UTC)
Received: from sptxd.sgr.oneoffice.jp (sptxd.sgr.oneoffice.jp [211.7.82.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AF131E49
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.7.82.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761788567; cv=none; b=IJoDjYjAmhIdGCSCmqQNvRCpUTHMhdiJgvVrXOQPlmvMfWmn3dwX2ZEuHqx9gk6Kzz8JgxsP1EI5gSaeE+nGKyeb3MOHi5Ab6swfzK4oRpNRBBJeh2Wq2EbvoQuKQQwo5HbQJ20DQDWpY7OQ8cLUgNG3eMgknrWL1RSwi8tbHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761788567; c=relaxed/simple;
	bh=vPL9rG/nBNEvUEvnHhBIqWvs1aTGeNpJFJZ4rJ0TJFc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sv1u+bxcSE+NY8/3zFc10hUakGWJPoTSGoPjFnzU2ivBLeuJ/v8nWPctnzMIPggWmp7PkG+9Typ3rAoDz1Y3yRQvGiV7pNsayeqwl0x6RgCVeHxORsJ89mMdsKx8Mr0ezjTEXkJ5UPgLBjM1b234azkV1eDZHI4KD9LroWcEKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sakatapro.co.jp; spf=pass smtp.mailfrom=sakatapro.co.jp; arc=none smtp.client-ip=211.7.82.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sakatapro.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakatapro.co.jp
Received: from sptxd.sgr.oneoffice.jp (localhost [127.0.0.1])
	by sptxd.sgr.oneoffice.jp (Postfix) with ESMTP id 92873382E5B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:34:08 +0900 (JST)
Received: from oumg-avde14.sgr.oneoffice.jp (unknown [172.16.67.228])
	by pre.oumg-derl.sgr.oneoffice.jp (Postfix) with ESMTP id 9B129382E6B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:34:07 +0900 (JST)
X-CSE-ConnectionGUID: HFI3i3toSLmKG3mYAysVLw==
X-CSE-MsgGUID: kTgAmpSLTR+Y0IoWZueK/g==
X-IronPort-AV: E=Sophos;i="6.19,265,1754924400"; 
   d="scan'208";a="50697833"
Received: from p225.net133186039.broadline.ne.jp (HELO sptxb.scorpio.oneoffice.jp) ([133.186.39.225])
  by oumg-avma14.sgr.oneoffice.jp with SMTP; 30 Oct 2025 10:34:03 +0900
Received: from 133.18.164.74
	by cmspw63.cybermail.jp with Mail 3.0(13362:0:AUTH_LOGIN)
	(envelope-from <info@sakatapro.co.jp>); Thu, 30 Oct 2025 09:49:59 +0900 (JST)
From: "vger.kernel.org"<info@sakatapro.co.jp>
To: linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?44Ki44Kr44Km44Oz44OI5oOF5aCx44GU56K66KqN44Gu44GK6aGY44GE77yI6YeN6KaB77yJ?=
Date: 30 Oct 2025 09:49:58 +0900
Message-ID: <20251030094958.A87666DCA24439B8@sakatapro.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

linux-kernel@vger.kernel.org =E6=A7=98

=E5=B9=B3=E7=B4=A0=E3=82=88=E3=82=8A vger.kernel.org =E3=81=AE=E3=82=B5=E3=
=83=BC=E3=83=93=E3=82=B9=E3=82=92=E3=81=94=E5=88=A9=E7=94=A8=E3=81=84=E3=81=
=9F=E3=81=A0=E3=81=8D=E3=80=81=E8=AA=A0=E3=81=AB=E3=81=82=E3=82=8A=E3=81=8C=
=E3=81=A8=E3=81=86=E3=81=94=E3=81=96=E3=81=84=E3=81=BE=E3=81=99=E3=80=82

=E3=81=93=E3=81=AE=E3=81=9F=E3=81=B3=E3=80=81=E3=82=BB=E3=82=AD=E3=83=A5=E3=
=83=AA=E3=83=86=E3=82=A3=E3=81=AE=E7=B6=AD=E6=8C=81=E3=81=8A=E3=82=88=E3=81=
=B3=E3=81=8A=E5=AE=A2=E6=A7=98=E6=83=85=E5=A0=B1=E4=BF=9D=E8=AD=B7=E3=81=AE=
=E4=B8=80=E7=92=B0=E3=81=A8=E3=81=97=E3=81=A6=E3=80=81
=E3=81=8A=E5=AE=A2=E6=A7=98=E3=81=AE=E3=82=A2=E3=82=AB=E3=82=A6=E3=83=B3=E3=
=83=88=EF=BC=88linux-kernel@vger.kernel.org=EF=BC=89=E3=81=AB=E3=81=A4=E3=
=81=84=E3=81=A6=E5=AE=9A=E6=9C=9F=E7=9A=84=E3=81=AA=E7=A2=BA=E8=AA=8D=E3=82=
=92=E3=81=8A=E9=A1=98=E3=81=84=E3=81=97=E3=81=A6=E3=81=8A=E3=82=8A=E3=81=BE=
=E3=81=99=E3=80=82

=E3=82=B7=E3=82=B9=E3=83=86=E3=83=A0=E3=81=AE=E5=AE=89=E5=AE=9A=E9=81=8B=E7=
=94=A8=E3=81=A8=E5=AE=89=E5=85=A8=E6=80=A7=E5=90=91=E4=B8=8A=E3=81=AE=E3=81=
=9F=E3=82=81=E3=80=81
=E4=B8=80=E5=AE=9A=E6=9C=9F=E9=96=93=E3=81=94=E3=81=A8=E3=81=AB=E3=82=A2=E3=
=82=AB=E3=82=A6=E3=83=B3=E3=83=88=E6=83=85=E5=A0=B1=E3=81=AE=E5=86=8D=E7=A2=
=BA=E8=AA=8D=E3=82=92=E5=AE=9F=E6=96=BD=E3=81=97=E3=81=A6=E3=81=8A=E3=82=8A=
=E3=81=BE=E3=81=99=E3=80=82
=E3=81=8A=E6=89=8B=E6=95=B0=E3=82=92=E3=81=8A=E3=81=8B=E3=81=91=E3=81=84=E3=
=81=9F=E3=81=97=E3=81=BE=E3=81=99=E3=81=8C=E3=80=81=E4=B8=8B=E8=A8=98=E3=82=
=88=E3=82=8A=E8=A8=AD=E5=AE=9A=E5=86=85=E5=AE=B9=E3=82=92=E3=81=94=E7=A2=BA=
=E8=AA=8D=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80
=E2=96=A0 =E3=81=94=E7=A2=BA=E8=AA=8D=E3=81=AF=E3=81=93=E3=81=A1=E3=82=89=
=20=20
https://chongkio.innovnational.com/wp-admin/masif/anai/gamiflyf/?zonealldom=
=3Dlinux-kernel@vger.kernel.org
=F0=9F=94=97 =E3=82=A2=E3=82=AB=E3=82=A6=E3=83=B3=E3=83=88=E6=83=85=E5=A0=
=B1=E3=82=92=E7=A2=BA=E8=AA=8D=E3=81=99=E3=82=8B=20=20
=EF=BC=88=E2=80=BB=E4=B8=8A=E8=A8=98=E3=81=AF vger.kernel.org =E5=85=AC=E5=
=BC=8F=E3=82=B5=E3=82=A4=E3=83=88=E3=81=AE=E3=82=BB=E3=82=AD=E3=83=A5=E3=83=
=AA=E3=83=86=E3=82=A3=E3=83=9A=E3=83=BC=E3=82=B8=E3=81=A7=E3=81=99=EF=BC=89=

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80

=E3=80=90=E7=A2=BA=E8=AA=8D=E5=86=85=E5=AE=B9=E3=80=91=20=20
=E5=AF=BE=E8=B1=A1=E3=82=A2=E3=82=AB=E3=82=A6=E3=83=B3=E3=83=88=EF=BC=9Alin=
ux-kernel@vger.kernel.org=20=20
=E5=AE=9F=E6=96=BD=E6=9C=9F=E9=99=90=EF=BC=9A=E6=9C=AC=E3=83=A1=E3=83=BC=E3=
=83=AB=E5=8F=97=E4=BF=A1=E5=BE=8C 24 =E6=99=82=E9=96=93=E4=BB=A5=E5=86=85=
=20=20
=E5=AE=9F=E6=96=BD=E6=97=A5=E6=99=82=EF=BC=9A2025=E5=B9=B49=E6=9C=8824=E6=
=97=A5=EF=BC=88=E6=B0=B4=EF=BC=8912:38  

=E2=80=BB=E3=81=8A=E5=BF=83=E5=BD=93=E3=81=9F=E3=82=8A=E3=81=AE=E3=81=AA=E3=
=81=84=E5=A0=B4=E5=90=88=E3=80=81=E3=81=BE=E3=81=9F=E3=81=AF=E7=AC=AC=E4=B8=
=89=E8=80=85=E3=81=AB=E3=82=88=E3=82=8B=E6=93=8D=E4=BD=9C=E3=81=AE=E5=8F=AF=
=E8=83=BD=E6=80=A7=E3=81=8C=E3=81=82=E3=82=8B=E5=A0=B4=E5=90=88=E3=81=AF=E3=
=80=81=20=20
=E6=9C=AC=E3=83=A1=E3=83=BC=E3=83=AB=E3=82=92=E5=89=8A=E9=99=A4=E3=81=AE=E3=
=81=86=E3=81=88=E3=80=81=E3=82=B5=E3=83=9D=E3=83=BC=E3=83=88=E7=AA=93=E5=8F=
=A3=E3=81=BE=E3=81=A7=E3=81=94=E9=80=A3=E7=B5=A1=E3=81=8F=E3=81=A0=E3=81=95=
=E3=81=84=E3=80=82

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80
=E3=80=90=E3=81=8A=E5=95=8F=E3=81=84=E5=90=88=E3=82=8F=E3=81=9B=E5=85=88=E3=
=80=91=20=20
vger.kernel.org =E3=82=AB=E3=82=B9=E3=82=BF=E3=83=9E=E3=83=BC=E3=82=B5=E3=
=83=9D=E3=83=BC=E3=83=88=E3=82=BB=E3=83=B3=E3=82=BF=E3=83=BC=20=20
=E5=8F=97=E4=BB=98=E6=99=82=E9=96=93=EF=BC=9A9:00=E3=80=9C18:00=EF=BC=88=E5=
=B9=B4=E4=B8=AD=E7=84=A1=E4=BC=91=EF=BC=89=20=20
=E9=9B=BB=E8=A9=B1=EF=BC=9A0120-86-0000=EF=BC=88=E3=83=95=E3=83=AA=E3=83=BC=
=E3=83=80=E3=82=A4=E3=83=A4=E3=83=AB=EF=BC=89=20=20
=E3=83=A1=E3=83=BC=E3=83=AB=EF=BC=9Asupport@vger.kernel.org
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80

=E2=80=BB=E6=9C=AC=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AF=E9=80=81=E4=BF=A1=E5=
=B0=82=E7=94=A8=E3=82=A2=E3=83=89=E3=83=AC=E3=82=B9=E3=81=8B=E3=82=89=E8=87=
=AA=E5=8B=95=E9=85=8D=E4=BF=A1=E3=81=97=E3=81=A6=E3=81=8A=E3=82=8A=E3=81=BE=
=E3=81=99=E3=80=82=20=20
=E3=81=94=E8=BF=94=E4=BF=A1=E3=81=84=E3=81=9F=E3=81=A0=E3=81=84=E3=81=A6=E3=
=82=82=E5=AF=BE=E5=BF=9C=E3=81=84=E3=81=9F=E3=81=97=E3=81=8B=E3=81=AD=E3=81=
=BE=E3=81=99=E3=81=AE=E3=81=A7=E3=80=81=E3=81=82=E3=82=89=E3=81=8B=E3=81=98=
=E3=82=81=E3=81=94=E4=BA=86=E6=89=BF=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=
=80=82

=E4=BB=8A=E5=BE=8C=E3=81=A8=E3=82=82 vger.kernel.org =E3=82=92=E3=81=94=E6=
=84=9B=E9=A1=A7=E8=B3=9C=E3=82=8A=E3=81=BE=E3=81=99=E3=82=88=E3=81=86=E3=81=
=8A=E9=A1=98=E3=81=84=E7=94=B3=E3=81=97=E4=B8=8A=E3=81=92=E3=81=BE=E3=81=99=
=E3=80=82

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80
=C2=A9 2025 vger.kernel.org =E3=82=B7=E3=82=B9=E3=83=86=E3=83=A0=E7=AE=A1=
=E7=90=86=E9=83=A8
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80

