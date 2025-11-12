Return-Path: <linux-kernel+bounces-896390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B682C503F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623C11889C30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF028D8CC;
	Wed, 12 Nov 2025 01:54:13 +0000 (UTC)
Received: from r9206.ps.combzmail.jp (r9206.ps.combzmail.jp [160.16.62.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B6261B9C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.62.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912453; cv=none; b=M2Xa0zMiS63zm0/quOwSlbbWvyX/sHfZgY26bJa+5VVFSgnkdWiazDjQsiIfZMftRLM2dgPHRST0B25YsjDmogrG6WUcVw5MhhYcRywVVpByrrfye3OGy3iyNO3szqMFhqxlfVj2DEmWvUIgJs7TOMXyBecAED7pRi2GFA90a0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912453; c=relaxed/simple;
	bh=MbJdxlQuC72L2/Wk4PEfLWempqScnpfV07BvSd1zw9M=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=tK0ilYKK0fDxImTKuGv3CovIm+If5GEcHdajLhyN+6Obhv/8Vss10IailTsJEqJXDro4Z47jL5Ixb+lqsSO2CVL4+F5pEhfxAxgi402EyxGhbbCufCFtNNHGhbrQP92wWcm5lSjrOJxa2Dr8DKQDaZm09MGP+fnMfxsM/ovzMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gosso.biz; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.62.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gosso.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9206.ps.combzmail.jp (Postfix, from userid 99)
	id D618E1034A2; Wed, 12 Nov 2025 10:43:09 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9206.ps.combzmail.jp D618E1034A2
To: linux-kernel@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCJEgkLSRvRGIlVSVpJXMlQSVjJSQlOjt2TDM2SRsoQg==?= <info@gosso.biz>
X-Ip: 19936271597168
X-Ip-source: k85gj76048dnsareu0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCQ08waCRLIUk9aSFJPVBFOSRHQUAkJiEiGyhC?=
 =?ISO-2022-JP?B?GyRCPkZGeSVeITwlMSVDJUgbKEI=?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 60re
X-uId: 6763325039485967644955161020
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20251112014339.D618E1034A2@r9206.ps.combzmail.jp>
Date: Wed, 12 Nov 2025 10:43:09 +0900 (JST)

　
　
　新たな事業をお考えの経営者様へ
　
　
　いつもお世話になります。
　
　待ち時間0秒の飲み放題　を提供する、
　焼肉酒場「 ときわ亭 」のフランチャイズシステム説明会をご案内いたします。
　
　
　わずか2年半で全国80店舗展開した
　「0秒レモンサワー　ときわ亭」の
　
　ビジネスモデル、収益性や最新の飲食市場実態を
　オンラインによる説明会形式でご案内します。
　
　
　第二部では、
　「融資を満額引き出す 事業計画書の書き方」
　についても徹底解説いたしますので
　
　・銀行融資を受けやすくなるコツをしりたい
　・飲食店の経営に興味がある
　・焼肉屋の経営実態がしりたい

　こういった方は、ぜひお気軽にご視聴くださいませ。
　
　
　▼　オンライン説明会のご視聴予約はこちら　▼
　　　https://tokiwatei-fc.work/online/

━━━━━━━━━━━━━━━━━━━━━━━━━━━

　■　ご説明するフランチャイズシステム
　　0秒レモンサワー　仙台ホルモン焼肉酒場ときわ亭

　■　開催日程
　・11月25日（火）15時〜17時　＠オンライン開催
　
　■　定員
　・10社
　
　■　参加費
　・不要

━━━━━━━━━━━━━━━━━━━━━━━━━━━━
本メールが不要の方には大変失礼しました。
今後ご案内が不要な際は、下記URLにて配信解除を承っています。
https://tokiwatei-fc.work/mail/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━
主催：GOSSO株式会社（ときわ亭フランチャイズ本部）
東京都渋谷区宇田川町14-13 宇田川ビルディング6F
03-6316-8191　
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

