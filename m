Return-Path: <linux-kernel+bounces-615009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF47A97517
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 21:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA18A17965E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2422989B3;
	Tue, 22 Apr 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=joelselvaraj.com header.i=@joelselvaraj.com header.b="HCsFCcCM"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839BF2989A4;
	Tue, 22 Apr 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348565; cv=none; b=VbpVqU0H5fEyM6ch4V0t0MINmd4q8Ad6Lz+BP48g6uvaG6FytDuQzeMFW5uWIIf2ZHeYGZkhcCjyUkYoDLFjonDfK5+gGhL58B/l4Hndyn9U+RQA3L4AoT5YDAHmzMMYovJH+TP6K3G/z1qQSRX5Bh3jJJpo00EGx5iCgLTW7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348565; c=relaxed/simple;
	bh=0+rggnwaWmlNWpjJmv1c2bbt4PZ1XHqtGeq99yflNHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oN+mS2GlbGvHhNYXhJWcxLxFbfNclwbDXXa54IoY4pYxRh5IWmqE0NDH2LPFuH0+UuGj5O5Rs7FlYjpcc1EB13g4X7YRaNPtpPFjLPR173EHINtdL/mwrKjFAZnKKE+qe8xd6wQfExDyYTozTbjq9gZiwQSMgFq43fSrc5akQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joelselvaraj.com; spf=pass smtp.mailfrom=joelselvaraj.com; dkim=pass (2048-bit key) header.d=joelselvaraj.com header.i=@joelselvaraj.com header.b=HCsFCcCM; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joelselvaraj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelselvaraj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joelselvaraj.com;
	s=protonmail2; t=1745348550; x=1745607750;
	bh=0+rggnwaWmlNWpjJmv1c2bbt4PZ1XHqtGeq99yflNHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=HCsFCcCMj3OjtsbUaFDP5z+ktC928HKV1kVwp77HCG5ui1hrGLqNl8WwsJCHEVqYG
	 yNJYK8PEIKZ/4I/27DGrn376GDDNeyvVFnyXlytDIadjvVo7yWcMkEKY/TDe1YnkAl
	 U+BlhWAAJzjvo/G2kxNsgNWSy31Uf5WdeTdfnIKVEfiW+3OYqDupb5PBA3zJk/u3Ix
	 u3u58jjQkQeuHZlG68rYMmy+Qk4R7/q4UODdphwIm49IMSeVlXnhG9rkt9BOY7vxOW
	 OMaVN5jgaCet1+QAZG3NDFs1eFxA77dcfPrFICcdwZsWKR/9rgE+75JHFhDNNzqxSO
	 6kzt7TQIJzoEg==
Date: Tue, 22 Apr 2025 19:02:26 +0000
To: Bjorn Andersson <andersson@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Joel Selvaraj <foss@joelselvaraj.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: input: touchscreen: edt-ft5x06: use unevaluatedProperties
Message-ID: <220cbe91-07d1-4512-bc7e-a5af8c03eb5b@joelselvaraj.com>
In-Reply-To: <lrgjgfupvtceac54tag7rn2hgglgaogic2n33q6vshbvv5exgq@eqefsbvvdkdz>
References: <20250303-pocof1-touchscreen-support-v4-0-cdc3bebc3942@joelselvaraj.com> <20250303-pocof1-touchscreen-support-v4-1-cdc3bebc3942@joelselvaraj.com> <Z8fzD-aF-hN0PeyD@google.com> <lrgjgfupvtceac54tag7rn2hgglgaogic2n33q6vshbvv5exgq@eqefsbvvdkdz>
Feedback-ID: 113812696:user:proton
X-Pm-Message-ID: 1b3f7eb186d3e0b6746a3446f07aff7f74ffd266
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bjorn Andersson and Dmitry Torokhov,

On 3/13/25 17:18, Bjorn Andersson wrote:
> On Tue, Mar 04, 2025 at 10:45:35PM -0800, Dmitry Torokhov wrote:
>> On Mon, Mar 03, 2025 at 04:36:55PM -0600, Joel Selvaraj via B4 Relay wro=
te:
>>> From: Joel Selvaraj <foss@joelselvaraj.com>
>>>
>>> In Xiaomi Poco F1 (qcom/sdm845-xiaomi-beryllium-ebbg.dts), the FocalTec=
h
>>> FT8719 touchscreen is integrally connected to the display panel
>>> (EBBG FT8719) and thus should be power sequenced together with display
>>> panel using the panel property. Since the edt-ft5x06 touchscreen bindin=
g
>>> uses almost all the properties present in touchscreen.yaml, let's remov=
e
>>> additionalProperties: false and use unevaluatedProperties to include al=
l
>>> the properties, including the needed panel property.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
>>
>> I believe this is better be merged through the arch tree together with
>> the dts changes.
>>
>=20
> Then I will have to come up with a motivation to why it needed to go
> together with the dts change ;)
>=20
> Please pick the binding change through the input tree and I'll pick the
> dts changes once the binding has landed in linux-next.
>=20
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>

A gently ping on this patch. It seems there was a confusion on which=20
tree the patch should go, but ended up not landing yet. Kindly let me=20
know if any further fixes are needed from my end. Would be nice to get=20
this landed. Thank you both.

Regards,
Joel Selvaraj


