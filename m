Return-Path: <linux-kernel+bounces-884698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC463C30D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDBD24E56A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB492EAB66;
	Tue,  4 Nov 2025 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kAKV9RTB"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E872DCC1B;
	Tue,  4 Nov 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256982; cv=none; b=PFIfZ0c2v++VZLUO05BzCbk3IUdaRE5fXnGd8eBHSYJmjGrq2EfZcWDEvv/c1rY+glJyaJvRZ4+7P5p6e91M76lYQTf0ue6Nbu+S7/j3/JFTHRaN/ZVxpofFpAhpWFyjUxEEN0Q35QGPdXsX4HYc34Wn88aWIeiFaQK8o3LMZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256982; c=relaxed/simple;
	bh=FvowAcvC8veNnfIagKTJiT6zHVzm/04aTlVqH5+9gAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tID5FZLjZny73yS7CAQHFbL3dA+OkVbTGOSHazDVVvvVsf+lOLmshY5LolQDX/PQEKw+EH9FQ97uvB71QDHPXeVMVQqzZhsVOXym2PCfkjZ+82o0cbvQ4QZzl3GFisQsiXfSL3nzI+mJsrW0zC1NGUwArK/oa9USEnodULL+iAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kAKV9RTB; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762256949; x=1762861749; i=markus.elfring@web.de;
	bh=FvowAcvC8veNnfIagKTJiT6zHVzm/04aTlVqH5+9gAw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kAKV9RTBBwBWrCEmHfipZDP+tHTP7F24FWGgMht5LK31ANv9ColMTaNWj3qpAPx4
	 0EbK4yPcFPFXJryrAdwTGFWxWjmBS14rnRDlJctinzwA6nePE03bk/x4/eT4/cbAn
	 qsilY3BWGRmTTROua/aw3BOFVKqu0ZKkIuv7Up+MfrqHwKeyJC0q0+Y4BZcqnKxpM
	 DutN2i2FhzhdCR/FhG+CIV1v+t9vdLfYzx9mHnsn/i5YAZ2Q6URQJxkhTWNGTUH1q
	 A0vfdmxlPyeL7Tw+tCpK9wmT2J21REEMk+AcRm8VLHm62TweXGDd1pAlw04fyn7VY
	 svHToC5zgA8z5lbamw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9VU-1vy4jF0F9s-00aQha; Tue, 04
 Nov 2025 12:49:09 +0100
Message-ID: <36c855fe-9a04-4e83-8e0c-641e2d7e3df9@web.de>
Date: Tue, 4 Nov 2025 12:48:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/cputable: Use pointer from memcpy() call for
 assignment in set_cur_cpu_spec()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Dmitry Vyukov <dvyukov@google.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <6c61cf90-5811-4450-b649-7a2c84584ee9@web.de>
 <3115e03a-1995-46f4-a902-47ba3cb99901@csgroup.eu>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3115e03a-1995-46f4-a902-47ba3cb99901@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+RRqGhBd2/z2HqHq1MqtyP9k9EOJTPbzT50PO1Sj8zYR1GdUlK
 t026HqJ1BRc4mPYN0JAIKQRPArlOJeO9auwWlBRa8KTWLN/P4jMc7FAftx85TvnKhbpP+og
 mD/brQwwcIFA7bm75Yb3/gONngUCcYiArSoBsC7EuhGSHLsK8gFrigoAmyGar1MPuAP0zBw
 pKpykaHC7jsW08CxgrFUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HyYHB8bf9Sw=;50WVPljSbn1kn6Nufwiu3k5yzvi
 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

>> A pointer was assigned to a variable. The same pointer was used for
>> the destination parameter of a memcpy() call.
>> This function is documented in the way that the same value is returned.
>> Thus convert two separate statements into a direct variable assignment =
for
>> the return value from a memory copy action.
>=20
> I can't see the added value of this change. For me it degrades readabili=
ty.

I dared to present another coding style view.


> Many places in cputable.c have that t =3D PTRRELOC(t) pattern,

Several assignment statements can occur.


> I can't see why that one should be changed while other ones remain.

Copy calls influenced the suggested source code transformation.


> Can you elaborate why this change is desirable ?

I imagine that selected variable assignments might be avoidable.

Regards,
Markus

