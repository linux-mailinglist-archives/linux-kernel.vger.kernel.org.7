Return-Path: <linux-kernel+bounces-628063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28AAA58B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 01:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178D9179C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0472288FB;
	Wed, 30 Apr 2025 23:30:07 +0000 (UTC)
Received: from r9103.ps.combzmail.jp (r9103.ps.combzmail.jp [49.212.47.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A3205519
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.47.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055807; cv=none; b=YnWkIzfVKoFJ3QCwTH4ye10O5Gse+veN5QOib72xEIdWm8uZMme40yEInDeyPBiOqqeKneYpSDKsAFT52jDzM3si8BSbSmvwaHM4CIZ7zPk5RRlcjkx4/gLJi0/T1b/09+MKnY2erEtamvSCvvS7RgoimdIKFWiMQhUFGiiFmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055807; c=relaxed/simple;
	bh=gwjJnRumWoLvNj3qviV1ZTAGA6bs3bwLKkqb7/fEMIw=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=rFW131dJCJVt6v2ydCxaPUtk98WufU/nKHt5frKhWMzE5++BjOIkuM8gnODG48uZC8eXf0JIEC43RtDHtGlMfFms9MOBT05Ptj9z0b2C79/CA01ZV1x9nyKyxF/0yVFDDp4vku/Fb91pk8UMWedU/49NpqJeas/yBDS6sNWTKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=japan-kaigo-s.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=49.212.47.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=japan-kaigo-s.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9103.ps.combzmail.jp (Postfix, from userid 99)
	id CDA6118887A; Thu,  1 May 2025 08:08:53 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9103.ps.combzmail.jp CDA6118887A
To: linux-kernel@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCRnxLXDJwOG4lNyU5JUYlYBsoQg==?= <info@japan-kaigo-s.jp>
X-Ip: 3084061826515111
X-Ip-source: k85gj7e448dnsa87u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?RkMbJEJKZz04GyhCIBskQj83NSwxRBsoQg==?=
 =?ISO-2022-JP?B?GyRCNkgkTiQkJGkkSiQkSyxMZDc/JE5NfUh+TUYlNSE8GyhC?=
 =?ISO-2022-JP?B?GyRCJVMlORsoQg==?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: e487
X-uId: 6763263937485961543963171016
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20250430231920.CDA6118887A@r9103.ps.combzmail.jp>
Date: Thu,  1 May 2025 08:08:53 +0900 (JST)

$B!!(B
$B!!!!!=!!?75,3+Bs$N1D6H3hF0$O$$$j$^$;$s!!!=(B
$B!!(B
$B!!(B
$B!!!!Ds7HJ!;c;\@_$+$i$N0MMj$,;&E~$7$F!"(B
$B!!!!5rE@ITB-$K$J$C$F$$$k!VK,Ld7?(B $BM}H~MF%5!<%S%9!W$N(B
$B!!!!%U%i%s%A%c%$%:2CLAE9$rJg=8$7$F$$$^$9!#(B
$B!!(B
$B"!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!~(B
$B!!(B
$B!!!!!A(B $B2CLAE9$X!"Ds7HJ!;c;\@_$r>R2p$9$k@)EY$,$"$j$^$9(B $B!A(B
$B!!(B
$B!!!!K,Ld7?$NM}H~MF%5!<%S%9(B
$B!!!!(BKami Bito$B!JH1?M!K(B
$B!!!!%U%i%s%A%c%$%:%7%9%F%`@bL@2q(B
$B!!(B
$B!!!!!=!!M}H~MF$N;q3J!&6H3&7P83$,L5$$J}$r!"4?7^$7$F$$$^$9!*!!!=(B
$B!!(B
$B!!(B
$B!!(B $B"~(B  $BF|!!Dx!!!'!!(B5$B7n(B9$BF|!J6b!K(B13:00$B!A(B14:00

$B!!(B $B"~(B $B3+:EJ}<0(B $B!'!!%*%s%i%$%s(B

$B!!(B $B"~(B  $BHq!!MQ!!!'!!L5NA(B

$B!!(B $B"~(B  $BBP!!>]!!!'!!K!?M!?8D?M;v6H<g!!$I$A$i$G$b2D!JL$7P83!"4?7^$G$9!K(B


$B!!(B          $B!!!!!!!!!!"'>\:Y!&?=9~"'(B
$B!!!!!!!!!!(Bhttps://kami-bito-fcseminar.jp/250509/


$B!!!!!!!!!!!!!!!!!!!!(B  $B!~!!<g!!:E!!!~(B
$B!!!!!!!!!!!!!!!!F|K\2p8n%7%9%F%`3t<02q<R(B

$B"!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!D(!!~(B


$B$$$D$b$*@$OC$K$J$j$^$9!#(B


$B$3$NEY!"K,Ld7?$NM}H~MF%5!<%S%9$N%U%i%s%A%c%$%:2CLAE9$r(B
$BJg=8$9$k@bL@2q$r3+:E$7$^$9$N$G$40FFb?=$7>e$2$^$9!#(B


$B!!""!!K,Ld7?$NM}H~MF%5!<%S%9$H$O!)!!""(B

$B!!!!!!9bNp$dIB5$!"%1%,!">c$,$$$J$I$N;v>p$G!"(B
$B!!!!!!30=P$,Fq$7$$J}$N$4<+Bp$d2p8n;\@_$J$I$K=PD%K,Ld$7!"(B
$B!!!!!!%+%C%H$rCf?4$H$7$?M}H~MF$r$4Ds6!$9$k%5!<%S%9$G$9!#(B


$B;d$?$AF|K\2p8n%7%9%F%`3t<02q<R$,%U%i%s%A%c%$%:E83+$9$k!V(BKamiBito$B!JH1?M!K!W$O(B
$BA49q(B4,300$B0J>e$NDs7HJ!;c;\@_$KBP$7$F%5!<%S%9$rDs6!$7$F$$$^$9!#(B


$B!V(BKamiBito$B!W$O8=:_!"KL3$F;$+$i2-Fl8)$^$G(B100$B5rE@0J>e$NBN@)$G(B
$BBP1~$7$F$$$^$9$,!"Ds7HJ!;c;\@_$+$i$N0MMj$,;&E~$7$F$*$j!"(B
$B$^$@$^$@5rE@$,ITB-$7$F$$$k$?$a%U%i%s%A%c%$%:2CLAE9$rJg=8$7$F$$$^$9!#(B


$B;v6H$r;O$a$k$K$"$?$C$F!"%*!<%J!<MM$KM}H~MF$N;q3J!&6H3&7P83$,L5$/$F$bLdBj$"$j$^$;$s!#(B


$B;d$?$A%U%i%s%A%c%$%:1?1DK\It$,!"M}H~MF;U$N%9%?%C%U:NMQ$r(B
$B%5%]!<%H$7$^$9$N$G%*!<%J!<MM$O%^%M%8%a%s%H$K@lG0$7$F$$$?$@$1$^$9!#(B


$B$5$i$K3+6H8e$O50F;$K>h$j$d$9$$$h$&$K!"4{B8$NDs7H;\@_0F7o$@$1$G$J$/!"(B
$BK\It$,99$KDs7H;\@_$N?75,3+Bs1D6H$r9T$$!"%U%i%s%A%c%$%:2CLAE9$K(B
$B$4>R2p$9$k@)EY$b$4$6$$$^$9!#(B


$B=i4|Ej;q!?<}1W@-!?2s<}4|4V!?K\It$+$i$N%5%]!<%H@)EY$J$I!"(B
$B@bL@2q$G>\$7$/$*EA$($7$^$9$N$G$46=L#$,$"$kJ}$O$3$N5!2q$K$4;22C$/$@$5$$!#(B


$B!!(B          $B!!!!!!!!!!"'>\:Y!&?=9~"'(B
$B!!!!!!!!!!(Bhttps://kami-bito-fcseminar.jp/250509/


***********************************************************************
$B$40FFbITMW$JJ}$K$OBgJQ<:Ni$7$^$7$?!#(B
$BG[?.Dd;_$N$*<jB3$-$O2<5-(BURL$B$K$F>5$C$F$$$^$9!#(B
$B"'G[?.Dd;_%U%)!<%`"'(B
$B!!(Bhttps://kami-bito-fcseminar.jp/mail/

***********************************************************************
$BF|K\2p8n%7%9%F%`3t<02q<R(B
$BBg:e;TCf1{6hK\D.(B1-5-7 $B@>B<%S%k(B5F
TEL:080-7475-9111$B!J%;%_%J!<;vL36I(B $BC4EvD>DL!K(B
***********************************************************************

