Return-Path: <linux-kernel+bounces-783631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11AB32FEE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AC1444A56
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555962D97BD;
	Sun, 24 Aug 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IFoGjT10"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2944255F39;
	Sun, 24 Aug 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039275; cv=none; b=nb/M4BLw0J/zKoX002017cSDTRPCaA7/b2ei6LoZcouLTncCtmej8Vlu8IP/S8tLXRHm/V0eVdG2tQAwUKwM1Mk4oNIPr2TCDxsJNeW/341VGxL4WTMX7vjIYAajS8gV/5jS2GjalpAq422Y0oo2ImMMbnBmIk91P+RHrKGwpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039275; c=relaxed/simple;
	bh=9xVHOw87bJa7ylZnZeZzWCvNeCzePjEsFVtSqjXXCNs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=A+1dNd3B4YdNmK9020J2kaKPwmwQcBjZOha+8u+K/GNd18lVLIzEPbdFtNTRc2VGie4bsSS+rlAFaN7XPxQlbA9G0or2VnHqv2ZxqMpNicFjo5HLAbr347t9Ue0casXHT7yHADrr/757lOqchVvQ8GdTzPQiQBx/nUw54/qz9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IFoGjT10; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756039264; x=1756644064; i=markus.elfring@web.de;
	bh=Tqa50LUKbPjx5CllJ9Yt080fvO8tlmlu1B/nkJ0AjBY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IFoGjT10L7jZ+juLGHbeW1ElBZNl7XDpHr5qxyF3T4iXW08WVlyZyg2wHco8QsPc
	 cXtjGg+BxW6NBK8expGK2yquE34b3Gjia11NK4rHSTRVd8uNwv0kpowxWh2lZ2CtN
	 s80kaumvSogL5pgQHnr9hIC/MV5UZ4OJDJuhpaR9UOFg9LWKgnDtVnRz+2I3tCg2P
	 Gldar9b2RT9Y6owzuI0U3WanAEILYYkm0g4A0uFmLLHjX1mHgZUD0mgSAgkeyB/L0
	 AgzvIDaQAluLRTUjnRcJB6TteWXAPm2TbVYGhAj5crxodBnatzdUlUxf+Ob9ZS4wH
	 ji62CkLusdrxfURVRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.216]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1ubG9P3GmN-00vMZR; Sun, 24
 Aug 2025 14:41:04 +0200
Message-ID: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
Date: Sun, 24 Aug 2025 14:40:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?B?W1JGQ10gQ2hvb3Npbmcg4oCcc2VtYW50aWNz4oCdIGJldHRlciBmb3Ig?=
 =?UTF-8?Q?SmPL_script_parts=3F?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1RvGBeE108ZCUP1seDcatK/mCtKGC1li0OfncC2/yvciZBuKRt
 nVzf4cuLAC2xcGxyBpmaKd1t7dav+a41oQzMczwfvXjwC0WihzW44VWfFOxi490EIn3dtHR
 PRpRAlij62zWOq/P4L3QbEMVnhB20vwX51usQ+089rQKmB1JzTaneSGwKE7C7G+Ahw/bCUh
 +8JDIqRqXkQGvNOXOMQKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+l5MbhXVxTY=;CnCmaCD5KqCYjyFSfAWFfvfSZ0g
 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
 kKxjMIo=

Hello,

A bit of information is provided about special =E2=80=9Csemantics=E2=80=9D=
 (also in the manual
for the semantic patch language).
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/face14907c0791b93397d=
5788d2a94c7c6a4b886/docs/manual/cocci_syntax.tex#L1007-1014

Usage possibilities are indicated for the key words =E2=80=9Cexists=E2=80=
=9D and =E2=80=9Cforall=E2=80=9D.

* Would any more software users like to discuss and clarify safer applicat=
ions
  of these system configuration parameters?

* Would you be looking for better =E2=80=9Cconnections=E2=80=9D according =
to computation tree
  logic (or linear temporal logic) variations?


Regards,
Markus

