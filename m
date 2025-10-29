Return-Path: <linux-kernel+bounces-877061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CAC1D1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A51566282
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A935A935;
	Wed, 29 Oct 2025 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="f8ATp90Q"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB82248A0;
	Wed, 29 Oct 2025 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767794; cv=none; b=if6RHv/89ad1RHPNX1AWuDz2ZnG6cODwSREid65QK6+5WhCrm1vwVG6lh0Q8jK39yP5mCj+tr9ORxrRdev+uMuKDgKap2glWGTdNKpsmlubYcmRI1NhIn8fXoHE/c7hDZJImj23ueTsphOLfCu3au03IvqFva+6kxR+HvK4QaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767794; c=relaxed/simple;
	bh=rf3OZEvaOCZgv1DBg0KNit39O6UOX5HMsEdmqlgtW2w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Y6i+0X1+RQqCAO9p/xaPSa6szUALJjDvQYwNKbs7oQvzX/iF3Nczfs87g9Mhf1l7lP5A+rIGzy1tcCchRUYrGMNIvHdbBuXj49m21Vpi8xT447f1kfsMKCEdhdguJQlTnlGUlkmeRPF4e1FvoNVW08VnOrG5rdk8TOgBx312seU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=f8ATp90Q; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761767788; x=1762372588; i=markus.elfring@web.de;
	bh=YEHOhUcFHey16lyYcbORugfcWN4+Nzo1dgcZeTDky2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f8ATp90Q3nQCBfLggZWJcyY1rBT9J37XCIaLlgrAFXV47PvHu7RjwL/pL5bnfglw
	 q/HM97xLKnNaQ1cBPpt84A/FeeN1rZ1AX7Ir8LRSImG0B9hatihcC+uiK2kJn4j4F
	 m40GRSULW50jNQBh1qbUg1w1TDM4QbJ0Ntsl47J0ByC1Ct8qhrVFjAiWDO4sRSjtp
	 rzNhM+e9vsodKFrq9QrHJk+XTnzlJzPtO1mvcfsp0zmdZzMWMDhE6R97Ks2iQMol6
	 Yri5b92sHTgWv5Rt6INAe5t4IflODBzQxKAyLrccpTswO/tu99+dF7fYxFe+4ENQT
	 kDY2qq3nw9Q+1Ng4wA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkEhH-1vymQf0Jgn-00ZdHw; Wed, 29
 Oct 2025 20:56:28 +0100
Message-ID: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
Date: Wed, 29 Oct 2025 20:56:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] Increasing usage of direct pointer assignments from memcpy()
 calls with SmPL?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8YbU0H3UkNK2M80Ij6vheyA3aAZaQMAyr9CgbhfweLj8TVd/YP3
 IzFbJqXND/AeXEy5D7xv4mP3f5Zw5xDziJYP0Dnx/+iNIJ7GOm+yAtIK8IJIoDJnuvSHQ5a
 A+8+aTdvB3BlJoMWecLA0pGpzVqw7hWm9CSgYVm8Vlz/GaydJdCE1JkyenDnCHU7yDv2TG9
 kaDZrgo4tVW5mzo9yxOog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zEmfI8NxgwI=;mcJozFaEFU3o7W5haAH0/SJlNjh
 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

Hello,

I got into the mood to try another simple source code transformation out w=
hich
can be achieved also by the means of the semantic patch language.

@replacement@
expression object, size, source, target;
@@
 target =3D
-         object;
 memcpy(
-       target
+       object
        , source,
        size);


Test result (according to the software combination =E2=80=9CCoccinelle 1.3=
.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --timeout 23 -j4 --chunksize 1 --no-loops -dir . =
=E2=80=A6/Projekte/Coccinelle/janitor/use_memcpy_assignment.cocci > =E2=80=
=A6/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy_assignment-no_loops-2=
0251029.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy=
_assignment-no_loops-errors-20251029.txt
real    5m35,579s
user    20m20,037s
sys     0m14,467s


It can be determined then from the generated diff file that mentioned
implementation details can be transformed in 304 source files at the momen=
t.
Thus I became curious if it would be supported to adjust any places there
according to (Linux) coding style preferences.

Regards,
Markus

