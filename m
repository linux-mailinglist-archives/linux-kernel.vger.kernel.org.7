Return-Path: <linux-kernel+bounces-802510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2EB452FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C91A6585C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6042C21DA;
	Fri,  5 Sep 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PIDODqNq"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E526B2A5;
	Fri,  5 Sep 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063789; cv=none; b=uyl4xXEF84+OoFZPNRoSpxSKRSu+Lrv5zMIqEzJ5/M7wembvc8FVkBqgAVFTnIThyt71ZjvseMuQExfFBDfWbYtxSWoNJ4sgBud2j48ViNxccnngyhTJx3ba0cXbE1qU/98pnNEAqLVJ3kPiAJuQwCHdv8obAnl0ZgW2JjqcVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063789; c=relaxed/simple;
	bh=XNP/r+TxlRIurgNJHIgXFs3tWQ7nh7YZAwRJr9xKh9g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SxQJmsNjC7nLrtNyx7Mf3FcisM9RBqeoNHZFOZpIHIQD2u8oUJz2BLx2M/My2L9ZrKrjNoPko3xetrJjRP2cwgtKwATttvi88SmjcOkKstfNIUzY0mIVlcGu41wPVp3lClTP9S3Kz1ghXKjT4byJRPrLAcJunnGoZMYrDtj7GnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PIDODqNq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757063779; x=1757668579; i=markus.elfring@web.de;
	bh=XNP/r+TxlRIurgNJHIgXFs3tWQ7nh7YZAwRJr9xKh9g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PIDODqNqaIVfPDXrbRCynikhmJp6IvYw9KDqOZdZ+681rAR+3Iz9Sf1vTMvnuvTP
	 zz1NgN5JBzsbFQ9jpBz6aXGWJdk2HPeZ0swwgFVmjRItF3TPNU0guRk4gRjGxKrOn
	 hu+pRag1VZhoePBKawpUlbqB4YzxzbkwIFzwxL/dIVqxJZMof/rSPirJSw+lXUapA
	 ZsIW3PFiewOH4MNiGtaWKzzUsLu9iRXLYMOsvIL8VUZ5glP4bXMIm74yqlV6YTc/V
	 hutTdEaNAdyECuef7qsR0FGhUWCaQ4nWSIlqxYlsd8fb6ezFoeVrJs013N7Zd1b9w
	 nNxWHD8BLkFw6Ck36Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.210]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1u7uNu47FI-00qKoB; Fri, 05
 Sep 2025 11:16:19 +0200
Message-ID: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
Date: Fri, 5 Sep 2025 11:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] Sharing data processing resources for selected SmPL scripts?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/eeXQpAaO2TDpJROFg9WwxgYije8mW7GHKOzTPKslDpAu/MVd6i
 3LoDrnw8GJSoTSjvlIVb52Bc7THzoPEjBgF9ACHE+bOkoQH8xqrajCWZdjj4k0CzwUjPHZ3
 RVtAJcN6nhXEiPpbfnEQpTy55KEc5lktctftm0LacDSM8mnjOM5qxu8p9c6vEtiKADrjyO4
 Kltzugzd8dBO5NEY2XkIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O8KnwkyHYx0=;BCPwoR1mNgCJNCZvhdhmIxAfQvI
 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
 jdg7XKTA7inJKwG2cLW

Hello,

I became curious if further developers would like to try the following script out
for the semantic patch language.


@display@
identifier action;
type t;
@@
*t * action(...)
 {
 ... when any
 }


I interpret such a search approach in the way that it should extract some data
from a lot of source code places.
Thus I imagine that it results also in special software run time characteristics
which matter especially for big codebases like Linux.

How do you think about to clarify corresponding data collections
and computation resources?

Related source code analysis concerns can eventually be also clarified.

* Handling of function declarations in header files

* Relevance of some preprocessor directives


Regards,
Markus

