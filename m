Return-Path: <linux-kernel+bounces-882338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59088C2A35B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D064EECE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5A299920;
	Mon,  3 Nov 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WRtBag7e"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E1296BC2;
	Mon,  3 Nov 2025 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151953; cv=none; b=W1S7Kq56R4p7nitB/surGV6UaFyDDXDjUOyShKFwiG+yUV5khZe+KHhp2G1X1cxknCVm/D+a1QGU1Y++J4IRQGSBYszU2cdHryChc9czj5mgPxbpooTdRrOGso97IkSdSst9q9CMPXgtSPPrI9zdsCkgjkAmPyHtZJ0YlK3ycZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151953; c=relaxed/simple;
	bh=KvVbsd6ZbRij1fHhpB6JzGzDmq819CeSgHdCguZQNts=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FIoHO+gdFReQxbVwjTNfKrJVY+spPDwWdvz67zX/aO32sox7Jc3Ug02E/4MKXMURjxYECVqJSjzjAZcx4qxhFmsYWdaYT3V2ClUu+GjpmmAZJiwq275c4PJzBMffiOfdnfB3vL8J4FDYec7FH3UaxdVsGMidPRUKImDRpstINvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WRtBag7e; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762151948; x=1762756748; i=markus.elfring@web.de;
	bh=FDFWRRpBPqjnFN4FdqMold9xa9YJ0i6+6AV+kyday3Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WRtBag7etyTFD4O6BgERz6lAwOjsMxFe4tKzSi9kK30XT09ysaZY0+x6suUBjSBY
	 vMmODlsx+NBgjPMNBcLxI4zh/afpXHINbtawO3oLAmMuRa1Uru46e020OtiHqxXch
	 BF97z8uw8d8C+2WITDVRuaBuv6zKna5GeUwYXr4RIPH8f38t0zPFGaGURzpXgvlYu
	 rgtWQWJB4ZzRCxj9ORpU09ikU3ehbGXSsZmM9eyV7Fc2NJOSqasulEGbAD1ogDi3z
	 M8leM38VeN1lHrFQ0hmBTIihdubwhogLCKLeJFGIokdNHK9QLOuTHnOAXqX8Vm4h/
	 EW7VL7u/Nm/h/isVNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1wGKn42yvr-00sqTz; Mon, 03
 Nov 2025 07:33:53 +0100
Message-ID: <61ead92e-c65e-4872-843b-4a71b395d486@web.de>
Date: Mon, 3 Nov 2025 07:33:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [RFC] Detecting missing null pointer checks after memory
 allocations
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <52e58416-d75f-4a47-9555-88a99d664069@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <52e58416-d75f-4a47-9555-88a99d664069@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3HphL8XTD+722qQpntcp9h0A43AU817vtHyiJ6jUJApesylpz6z
 SOxa48YTGark50m6GXwRY2m8smsvjGHAUzPg0rRuiYFoaM/1nq+Tj1WG1u3exUVlnovN4c8
 N+S8kBsIlYiGtV2PXeEjIM+y5bDfDpjan0Dt8JsLQLAxtVV/YtLypJpmxuLyeAJQJyevBSW
 8J7qAKsKQ/bpkppqPTx8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GJQu4yOa6KE=;pddJSlLeh4W5fuK+DcYNfagWj7S
 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

> I got into the mood to try another simple source code search out which
> can be achieved also by the means of the semantic patch language.

I would like to present further data processing approaches accordingly.
The application of a tiny function name selection was demonstrated
by an SmPL disjunction (which can be extended on demand).
Additional techniques can become more helpful for advanced code reviews.

* Further preparations would be needed in software infrastructures (ACID p=
roperties)
  if you would like to benefit more from parallel data processing here.

* It might be easier for a while to stick to a serial data processing appr=
oach
  like the following.


@initialize:python@
@@
import sys
records =3D []

def store_data(id, places):
   """Add data to an internal list."""
   for place in places:
      records.append((id, place.current_element, place.file, place.line, s=
tr(int(place.column) + 1)))

@searching@
expression size, source, target;
identifier action;
position pos;
@@
 target =3D action@pos(...);
 memcpy(target, source, size);

@script:python collection@
id << searching.action;
place << searching.pos;
@@
store_data(id, place)

@finalize:python@
@@
if records:
   delimiter =3D "|"
   sys.stdout.write(delimiter.join(["action", '"function name"', '"source =
file"', "line", "column"]) + "\n")

   for record in records:
      sys.stdout.write(delimiter.join(record) + "\n")
else:
   sys.stderr.write("No result for this analysis!\n")



A text file can accordingly be generated by the Coccinelle software. It ca=
n be
imported into a spreadsheet application. A Pivot table can be constructed =
then.

Would you become interested to take another look at the 71 called actions
(from 121 source files of the software =E2=80=9CLinux next-20251031=E2=80=
=9D) if they would need
the check for a failure predicate before copying data to affected memory a=
reas?
https://cwe.mitre.org/data/definitions/252.html

Under which circumstances will error detection and corresponding exception
handling be completed?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers#EXP34C.Donotdereferencenullpointers-AutomatedDetection

Regards,
Markus

