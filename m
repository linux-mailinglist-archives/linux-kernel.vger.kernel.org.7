Return-Path: <linux-kernel+bounces-823398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C0B86512
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB53F165A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838025A2AE;
	Thu, 18 Sep 2025 17:48:50 +0000 (UTC)
Received: from sub0000529476.hmk-temp.com (mail.btob-mail.work [180.222.184.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661401E3DE5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.222.184.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217729; cv=none; b=mAOxnwh2TD7WXWcLn4EUOItJsaApjj0WJiKFu5JlxcNdMogKB+65YevG8EmlPcYMgcMe0rI82Uc2TnP4hZf8/rypxXGr9/KtffTsAhWYxZIZV9KQ6qIswd22Vg8jC7WgPZF1zWJiol6YrsQRpWYqKOOa62ltQjl+I5zW0zSUV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217729; c=relaxed/simple;
	bh=XWhwz5XfX6dcp6E8MvIbZWFetA2FciHeSNylbn60qUY=;
	h=From:To:Subject:Content-Type:Date:Message-ID; b=mVTD0Jh+XF4S/4Lw3SCXdD995E5i+ggatUY7PSP6ae6NMy15x3UgrD4ZXjLjjqLMSlB5DibpJ9sp5a+K5H6r2Z1Yie7b3+nZZhmtQcDXZ/j7Vd0lrEpIWKlkxLo4bUiBJSK3qmzCrpsZf25fCnKwUdd111XSYfcy2lxYXATotFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=headmint.biz; spf=fail smtp.mailfrom=headmint.biz; arc=none smtp.client-ip=180.222.184.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=headmint.biz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=headmint.biz
Received: (qmail 2051 invoked from network); 18 Sep 2025 22:23:02 +0900
Received: from softbank060111101004.bbtec.net (HELO MailD-4) (60.111.101.4)
  by mail.btob-mail.work with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 18 Sep 2025 22:23:02 +0900
From: =?iso-2022-jp?B?GyRCJVglQyVJJV8lcyVIGyhC?= <info@headmint.biz>
To: linux-kernel@vger.kernel.org
Subject: =?iso-2022-jp?B?GyRCJCIkPyReQGxMZyROJGIkXyRbJDAkN0U5GyhCIA==?==?iso-2022-jp?B?GyRCPH0xV0AtRXkhPzM1TVc7cU5BGyhC?=
X-Mailer: Mail Magic Professional Version 16
Content-Type: text/plain;
	charset=iso-2022-jp
Date: Thu, 18 Sep 2025 23:24:46 +0900
Message-ID: <202509182324460722.FBD52C56DCBB4A6AAFEF2A65252D16D4@btob-mail.work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

$B$*@$OC$K$J$j$^$9!#(B


$B%3%s%Q%/%H$K%9%?!<%H$G$-$F<j7x$/<}1W$r$"$2$k$3$H$N$G$-$k(B
$B%U%i%s%A%c%$%:%S%8%M%9$N;v6H35MW;qNA$r$40FFb?=$7>e$2$^$9!#(B


$B!!!!!!(B $B>.;qK\!?>.%9%Z!<%9!?>/?M?t$N(B
$B!!!!!!!!%3%s%Q%/%H!&%U%i%s%A%c%$%:(B

$B!!!!!!!!!!%I%i%$%X%C%I%9%Q@lLgE9(B
$B!!!!!!!!!!!!(B $B!H%X%C%I%_%s%H!I(B

$B!!!!!!!!!!!!!!!&<}1W%b%G%k(B
$B!!!!!!!!!!!!!!!&3+6H$KI,MW$J;q6b(B
$B!!!!!!!!!!!!!!!&%m%$%d%j%F%#(B
$B!!!!!!!!!!!!!!!&%9%1%8%e!<%k!!(Betc
$B!!!!(B $B!!!!(B $B"-!!(B FC$B;v6H35MW;qNA(B $B!!"-(B
  $B!!(B $B!!(B https://dryheadspa-hm.biz/fc/


$B%I%i%$%X%C%I%9%Q$H$O!!!=!=!=!!?e$r;H$o$J$$%X%C%I%9%Q$G$9!#(B


$BB-$D$\$d<*$D$\$J$I!"@lLg$N$b$_$[$0$7E9$,$"$j$^$9$,(B
$B$4>R2p$9$k%5%m%s$O!V!!F,$KFC2=$7$?$b$_$[$0$7E9!!!W$G$9!#(B


$B%I%i%$%X%C%I%9%Q$H$$$&%8%c%s%k$NG'CNEY$O!"(B
$B8=;~E@$G$O$=$l$[$I9b$/$"$j$^$;$s!#(B


$B$K$b4X$o$i$:!";d$I$b$,%U%i%s%A%c%$%:E83+$9$k!H%X%C%I%_%s%H!I$N(B
$BE9J^$K$O7n4V(B450$B?M0J>e$N?75,5R$,MhE9$7!"K~@J$,B3$$$F$$$^$9!#(B


$B$3$l$+$i@h!"G'CNEY$,9b$^$k$3$H$G(B
$BGzH/E*$K?-$S$k%]%F%s%7%c%k$rHk$a$F$$$^$9!#(B


$B%U%i%s%A%c%$%:$K$h$k;v6H$rE83+$7$F$$$^$9$N$G!"(B
$B?7$?$J<}1W$E$/$j$r$*9M$($NJ}$O!"$^$:$O35MW;qNA$r$4Mw$/$@$5$$!#(B


$B!!!!!!!!!!%I%i%$%X%C%I%9%Q@lLgE9(B
$B!!!!!!!!!!!!!!!!%X%C%I%_%s%H(B
$B!!!!!!(B
$B!!!!(B $B!!!!(B $B"-!!(B FC$B;v6H35MW;qNA(B $B!!"-(B
  $B!!(B $B!!(B https://dryheadspa-hm.biz/fc/


$B$h$m$7$/$*4j$$$7$^$9!#(B


------------------------------------------
$B!!3t<02q<R$8$`$d(B
$B!!0&CN8)L>8E20;TCf6hBg?\(B3-26-41$BKYED%S%k(B
$B!!(BTEL$B!'(B052-263-4688
------------------------------------------
$B!!K\>pJs$,$4ITMW$JJ}$K$O$4LBOG$r$*$+$1$7?=$7Lu$4$6$$$^$;$s!#(B
$B!!%a!<%k%^%,%8%s$N2r=|$O!"2<5-(BURL$B$K$F>5$C$F$*$j$^$9!#(B
$B!!(B https://dryheadspa-hm.biz/mail/
$B!!$*<j?t$*3]$1$7$^$9$,$h$m$7$/$*4j$$$7$^$9!#(B

