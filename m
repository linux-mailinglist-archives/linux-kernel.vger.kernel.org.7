Return-Path: <linux-kernel+bounces-732347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DBB06575
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C517AD67E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90537291C25;
	Tue, 15 Jul 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="a9cy1Ddl"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C427465A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602465; cv=none; b=kdbhGQZrHNaHm+LztHU/4ys3LTijr0ZaA7BlYb8geaYfmZbkl+qvy5wOF45TYAaWNoRNIR8Gi1m8evYx037fR0WmmWTYXlW221J+DVuvef5G6QJTTzgTVvJhFmhoQLg8J30Pt7t/DGUTDJ/SXyK0Yg3imAaevRsmrCWsmjp3X8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602465; c=relaxed/simple;
	bh=1+DdKk3mG9w9k6zQliurI+nUuSnJfcsTUPhXQCQkVYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJeXVuL6E+HeZFhxDDDg6ujFote4cYlgkPZUSjQEFd/n7IA/UttQoK4Vqe4irVew1dkO5O3cP9x2eYGZD6qFsdNk8/WlWJPmBiyO4X0ao2bu72+3EnUt/QX8WMQm/mnr7LBB7kec10mztL/OxMV00Ajuf4qpd0+0JeZw+nFZR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=a9cy1Ddl; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <24b87877-8132-4cab-a0d7-f139bdc34d92@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1752602460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OY//la/H2xbgv1uwDw1f49/EO9B11bYJlwE4wsn3qxU=;
	b=a9cy1DdleDaKbKo6QuicmNFJl32BCDiD6Jx5CwqCKK1m8pT3Cfmeosi/RXM63M6BlBJLyN
	PaUZ3Ul4SGjZJklpZgZ13Z1caZFl//hZ+gp+VPDI7feTPKTV+8HGAnKqyhddf8fM2U0cuS
	3XUMTbcv79Qkqnnt/G5QRuby7B26Xo7+OJTsnHoxcmkMDtRoQpEqCviKKucOuTp8GYSST7
	Qo9Kxt73KDjeFyo7Wpt42Wp1o8IH+yOrWReFq5dggWG4p6eqVjN5yUsvUwcfWLoxBtK8WQ
	kJh/RsWvtbWBOVMYtSCnyZY1QRqkbVl1ZMuyBrGKxstE0nmCjdBmJFUx/WVEEA==
Date: Tue, 15 Jul 2025 15:00:49 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: Add support for Dell Inspiron
 7441 / Latitude 7455
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250706205723.9790-2-val@packett.cool>
 <20250706205723.9790-5-val@packett.cool>
 <301542db-2e0d-48ff-94d0-09acaa603ace@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <301542db-2e0d-48ff-94d0-09acaa603ace@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/14/25 10:35 AM, Konrad Dybcio wrote:
> On 7/6/25 10:50 PM, Val Packett wrote:
>> +	wcd938x: audio-codec {
>> +		compatible = "qcom,wcd9385-codec";
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wcd_default>;
> Please do:
>
> property-n
> property-names
Ack
>> +&usb_mp_dwc3 {
>> +	phys = <&usb_mp_hsphy0>, <&usb_mp_qmpphy0>;
>> +	phy-names = "usb2-0", "usb3-0";
>> +};
> Let's not override this, so that the driver can still put the
> remaining ones to sleep cleanly

This was added for a reason, after all-
Just tested booting without this, and the USB-A port does not work, with 
this in dmesg:

platform a400000.usb: deferred probe pending: dwc3: failed to initialize 
core

So it seems like the other ones "don't exist" / have been shut down 
completely by boot firmware(?)

Will add a clarifying comment.

~val


