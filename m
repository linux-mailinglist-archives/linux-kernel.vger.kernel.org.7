Return-Path: <linux-kernel+bounces-799653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D3B42EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C731C2214F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E36199949;
	Thu,  4 Sep 2025 01:02:57 +0000 (UTC)
Received: from r9206.ps.combzmail.jp (r9206.ps.combzmail.jp [160.16.62.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCE10E0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.62.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947776; cv=none; b=F8K1PggqNq+eoJTU5rdse2iJu2cmXPQTAtpbCzajnKdX0gWzQLobQ6i0nAtlvPH7/cRRkvIZEgd2hIUFXv6PdGcM9HhjnFiToDxQ2HtOBz1WDvWtupmg56SScCiiHwvxVKdVh+CqZ3NmbOPZtjAuRHHCHj7O6jWL7mSaHG38UvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947776; c=relaxed/simple;
	bh=axWwrDS18HIJCEVjQdEfDJ44H28AbiiKgHuDEiuX3TI=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=iSXMNlLBE9dnxOTYu/+pzV8Wth4P/LJl6W0cOCfg8sWV+aCx+xcq7MjbeWc+mAtPT6qiAGkFPngKZxG5WaWD50OOYK1kUZSmGClbL7LJFqoOw4z/oXzy5OBi5fNf0J64M0pJtgN87RUfexBf8xPEmMRINpunUvaakJUY9tKkZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=p-healthtech.work; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.62.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=p-healthtech.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9206.ps.combzmail.jp (Postfix, from userid 99)
	id E739B1038D6; Thu,  4 Sep 2025 10:02:16 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9206.ps.combzmail.jp E739B1038D6
To: linux-kernel@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCJDEkcyQ1JF0bKEI=?= <info@p-healthtech.work>
X-Ip: 200702634529294
X-Ip-source: k85gj79348dnsa8ju0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCPT42SDB3JE43cjkvNElNfRsoQg==?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 938j
X-uId: 6763304238485965565052571030
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20250904010245.E739B1038D6@r9206.ps.combzmail.jp>
Date: Thu,  4 Sep 2025 10:02:16 +0900 (JST)

$B!!(B
$B!!$$$D$b$*@$OC$K$J$j$^$9!#(B

$B!!=>6H0w$N7r9/4IM}$K$*$$$F!"!V(B $B7n3[(B100$B1_!A!W$H$$$&05E]E*$J%3%9%Q$G(B

$B!!<B6HL3IiC4$r8:$i$9$N$KLrN)$D4IM}%5!<%S%9$r$4>R2p$9$k(B
$B!!%&%'%S%J!<$r$40FFb?=$7>e$2$^$9!#(B
$B!!(B
$B!!(B
$B!!%"%J%m%0(B/$B%G%8%?%k(B $BN>LL$+$i;Y$($k(B
$B!!!!!!=>6H0w$N7r9/4IM}%5!<%S%9(B
$B!!!!(B $B!!!!!!!H(B $B$1$s$5$](B $B!I(B

$B!!!!(B9$B7n(B17$BF|(B($B?e(B)
$B!!!!%*%s%i%$%s3+:E%;%_%J!<(B

$B!!!!"!!!!!(B $B!!>\:Y!&?=9~!!!!!!"!(B
$B!!!!!!(Bhttps://knsp.work/seminar/

$B"(=>6H0w(B100$B?M0J>e$J$I!"4IM}$9$k?M0w$,B?$$(B
$B!!4k6HMM$[$I%a%j%C%H$,Bg$-$/$J$j$^$9(B


$B!!7r9/?GCG$K$*$1$kF|DxD4@0!&M=Ls$NJQ99!"7k2L>pJs$N2s<}$d(B
$B!!4IM}$J$I$N6HL3$rIiC4$K46$8$k$3$H$,$4$6$$$^$;$s$G$7$g$&$+!#(B


$B!!$=$&$7$?J}$K$*$9$9$a$9$k$N$,!"7r9/4IM}6HL3$r$^$k$4$H(B
$B!!$*G$$;$G$-$k=>6H0w$N7r9/4IM}%5!<%S%9!H(B $B$1$s$5$](B $B!I$G$9!#(B


$B!!!H(B $B$1$s$5$](B $B!I$O!"<j4V$N$+$+$k7r9/?GCG6HL3$NBe9T$+$i(B
$B!!>pJs$r0l852=$9$k7r9/4IM}%7%9%F%`$^$G!"%"%J%m%0!&%G%8%?%kN>J}$N;Y1g$r(B
$B!!!V(B $B7n3[(B100$B1_!?=>6H0wKh(B $B!W$H$$$&05E]E*$J%3%9%Q$G<B8=$7$^$9!#(B


$B!!%*%s%i%$%s%;%_%J!<$K$F>\:Y$r$*EA$($7$^$9$N$G!"(B
$B!!$46=L#$,$"$l$P!"2<5-(BURL$B$h$j;kD0$r$*?=$79~$_$/$@$5$$!#(B

$B!!$h$m$7$/$*4j$$$7$^$9!#(B


$B!!%"%J%m%0(B/$B%G%8%?%k(B $BN>LL$+$i;Y$($k(B
$B!!!!!!=>6H0w$N7r9/4IM}%5!<%S%9(B
$B!!!!(B $B!!!!!!!H(B $B$1$s$5$](B $B!I(B

$B!!!!(B9$B7n(B17$BF|(B($B?e(B)
$B!!!!%*%s%i%$%s3+:E%;%_%J!<(B

$B!!!!"!!!!!(B $B!!>\:Y!&?=9~!!!!!!"!(B
$B!!!!(B https://knsp.work/seminar/

$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B
 $B"#3t<02q<R(BPersonal Health Tech
$B!!EEOC!'(B0120-984-925
$B!!=;=j!'Bg:e;TCf1{6hFnK\D.(B2-2-3$B!!(B $BK\D.(BUNICO$B%S%k(B4F
$B!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=(B
$BK\%a!<%k$N$4ITMW$JJ}$K$OBgJQ$4LBOG$r$*$+$1$$$?$7$^$7$?!#(B
$B:#8e!"$40FFb$,ITMW$G$7$?$i!"$*<j?t$G$9$,0J2<$h$j$*<jB3$-$N>e(B
$B%o%s%/%j%C%/2r=|$r$*4j$$$$$?$7$^$9!#(B
https://knsp.work/mail/
$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B

