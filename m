Return-Path: <linux-kernel+bounces-813944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE5B54D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C579A1D630EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F030BB8E;
	Fri, 12 Sep 2025 12:09:37 +0000 (UTC)
Received: from listy.pwr.edu.pl (listy.pwr.edu.pl [156.17.197.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150F334394
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.17.197.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678976; cv=none; b=Ogp4ih4f2SjgAVSDT8NCKiQBB+LflV8jLbIdNnrW+fHNLac02Jcp5/9DWT6sG4jy3IM0ozYrr7aQUWGYRKOed24HyYmHSad2PZAIf3FE4rTSYLgGseyEyStKmoCtt/BZK/csF40jeJAclqvp9qL7R0aQm3rJR++eIijP0pkd23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678976; c=relaxed/simple;
	bh=qeC0VwQNoGyOlB3jo/7Sk1tjZgJZR6tUCkYQJORfiIs=;
	h=Message-Id:Date:To:Subject:From:Mime-Version:Content-Type; b=ExN8WNpIe4mDTLBYOq6xmbGzEhG0tXD39kDbdryvrxg6N9VNvaxuwtXfXXV29u/cd53JKeQxUBPOvI64uqiRoEQKFb8mPuttI5PnpoEXTW2VCKFiA/Xs01JyFJJcNyq86jeQsCLZ+eqnearES8js4c/oVQ/QnD/IVabE+IBn+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e-informatyka.pl; spf=pass smtp.mailfrom=e-informatyka.pl; arc=none smtp.client-ip=156.17.197.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e-informatyka.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e-informatyka.pl
Received: from localhost (156-17-130-43.ii.pwr.edu.pl [156.17.130.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: e-informatica@listy.pwr.edu.pl)
	by listy.pwr.edu.pl (Postfix) with UTF8SMTPSA id 7B12C4048D9D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:09:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 listy.pwr.edu.pl 7B12C4048D9D
Message-Id: <1757678955503076906.1.8547899879744491708@listmonk.example.com>
Date: Fri, 12 Sep 2025 12:09:15 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Listmonk-Campaign: 3a7c403b-d6d7-4d3d-8941-05ff08f62f54
Content-Transfer-Encoding: quoted-printable
To: <linux-kernel@vger.kernel.org>
Subject: Publish Your Research in e-Informatica Soft. Eng. Journal (IF=1.2, Open Access, Free of Charge)
From: "e-Informatica Software Engineering Journal" <e-informatica@e-informatyka.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Listmonk-Subscriber: 0adc0220-7bc8-4f1d-86b1-177f6654fd40
Content-Type: text/plain; charset=UTF-8

Dear colleague,

We would like to invite you to submit your papers to the e-Informatica Soft=
ware Engineering Journal (EISEJ).

We particularly invite papers focused on:
- software engineering or=20
- the intersection of data science (AI/ML) and software engineering.

Our strengths:
- excellent, international Editorial Board (https://www.e-informatyka.pl/in=
dex.php/einformatica/editorial-board/)
- *open access without any authorship fees*, =20
- no paper length limit,
- fast, continuous publishing model with papers edited and published immedi=
ately after acceptance,
- rigorous, blind peer-review process.

Our achievements:
- ISI WoS with Impact Factor (IF=3D1.2, 5 Year IF=3D1.3) calculated by Clar=
ivate (https://jcr.clarivate.com/jcr-jp/journal-profile?journal=3DE-INFORMA=
TICA&year=3DAll%20years),=20
- Scopus (https://www.scopus.com/sourceid/21100259509) with CiteScore=3D3.5=
,=20
- DBLP (https://dblp.uni-trier.de/db/journals/eInformatica/index.html),=20
- Directory of Open Access Journals (https://doaj.org/toc/2084-4840),=20
- Google Scholar (https://scholar.google.pl/citations?user=3D8-uDLDoAAAAJ&h=
l) etc.

Apart from classic research papers, we invite you to submit:
- systematic reviews (incl. systematic mapping/scoping studies),=20
- surveys,
- research agendas,
- vision papers.=20

We not only invite you to submit papers (https://mc.manuscriptcentral.com/e=
-InformaticaSEJ), but also to organise special sections (please get in touc=
h with us at e-informatica@pwr.edu.pl).

We would be grateful for your feedback as well. Please let us know what we =
lack, what we did not think about, or what we should do to become an even m=
ore attractive venue from your point of view!
Let us collaborate on any excellent idea within the scope of the journal!

With very best wishes,
e-Informatica Software Engineering Journal (EISEJ)
Editors-in-Chief
Lech Madeyski and Miroslaw Ochodek

EISEJ website: https://www.e-informatyka.pl/
EISEJ submission site: https://mc.manuscriptcentral.com/e-InformaticaSEJ

