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

　
　いつもお世話になります。

　従業員の健康管理において、「 月額100円〜」という圧倒的なコスパで

　実業務負担を減らすのに役立つ管理サービスをご紹介する
　ウェビナーをご案内申し上げます。
　
　
　アナログ/デジタル 両面から支える
　　　従業員の健康管理サービス
　　 　　　“ けんさぽ ”

　　9月17日(水)
　　オンライン開催セミナー

　　◆　　 　詳細・申込　　　◆
　　　https://knsp.work/seminar/

※従業員100人以上など、管理する人員が多い
　企業様ほどメリットが大きくなります


　健康診断における日程調整・予約の変更、結果情報の回収や
　管理などの業務を負担に感じることがございませんでしょうか。


　そうした方におすすめするのが、健康管理業務をまるごと
　お任せできる従業員の健康管理サービス“ けんさぽ ”です。


　“ けんさぽ ”は、手間のかかる健康診断業務の代行から
　情報を一元化する健康管理システムまで、アナログ・デジタル両方の支援を
　「 月額100円／従業員毎 」という圧倒的なコスパで実現します。


　オンラインセミナーにて詳細をお伝えしますので、
　ご興味があれば、下記URLより視聴をお申し込みください。

　よろしくお願いします。


　アナログ/デジタル 両面から支える
　　　従業員の健康管理サービス
　　 　　　“ けんさぽ ”

　　9月17日(水)
　　オンライン開催セミナー

　　◆　　 　詳細・申込　　　◆
　　 https://knsp.work/seminar/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 ■株式会社Personal Health Tech
　電話：0120-984-925
　住所：大阪市中央区南本町2-2-3　 本町UNICOビル4F
――――――――――――――――――――――――――――
本メールのご不要な方には大変ご迷惑をおかけいたしました。
今後、ご案内が不要でしたら、お手数ですが以下よりお手続きの上
ワンクリック解除をお願いいたします。
https://knsp.work/mail/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

