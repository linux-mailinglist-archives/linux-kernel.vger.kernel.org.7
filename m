Return-Path: <linux-kernel+bounces-895152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBBC4D09B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E521894D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031E346FD0;
	Tue, 11 Nov 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="Y59Vz5Cy"
Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6634D4D6;
	Tue, 11 Nov 2025 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857010; cv=pass; b=PYHtVhHr8ZUO5b8KAMo5YZqlxgzlakrXtcGqk/S1EeiaTLDiQ6jQxgIBihCCIITdROXUR95T332tR0+37gNNdIUUITh4F0EF9soLpdfPX80iGplEH7S7rU//5HIHxa0wv8QEnITBZszDo3lttizRVgft+L4YR2t1jrp+wZNfkAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857010; c=relaxed/simple;
	bh=gryKLH1oBIJvs26Dicg2XpxMi5WNiOVrxPI0ZTiCAzo=;
	h=Message-ID:MIME-Version:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=LBve8zhDMwOnXHFkM1+XmrZG3xB+vM3IqRooJAwMh7JhD/Av1bbFPnBh4CVvKqKZ83anGzwGk+fd5mcNDNNOlayysD8/oTqzz7vbdfcwHRZ/RQE4mNR0Nr3B1HPXHgas5Zgy60rpySajsKog2nMXmEkA8q+1SzRvUeTROTZ+wRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=Y59Vz5Cy; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6DEBA18323B;
	Tue, 11 Nov 2025 10:30:01 +0000 (UTC)
Received: from de-fra-smtpout9.hostinger.io (100-121-222-5.trex-nlb.outbound.svc.cluster.local [100.121.222.5])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 65521183268;
	Tue, 11 Nov 2025 10:29:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762857001; a=rsa-sha256;
	cv=none;
	b=d21LOJ4Dg3a1WngEf80JJHMlfd61Kf611U3K9GVRm67Uzznnm92ca+4dFf5FBEnx9/IMRM
	ZB0pUFwYvpDr3qj39y6xYt+GRjkFTkW5MOuQNNh39494/I+/2flAbURe5xdGRaBUm+PsqG
	rqSmpow2dYOKd88Vwndoe9+ZWeCoTDwL6RievltMMxS2Upm2RI/JLfmmr1W2p8P11obveC
	hmL5+Fl1FsipO3CnMqM6rXEUC5nAXJoiQMthyRdB8ZqwVUwjta/hBG/qljHxD2DJrRbCnK
	0JS68H2KS5LW6bfx2gIi3QjbR6O+MsE8FraUT/ze43kbvuV+enSrZZmYktKLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762857001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2Qfd38hEYraSzh4msAcAjnFoyuX5aFZrJHQNeV8binU=;
	b=e/pGXJ05WFdNTJUP1DvF4KYv8//2ScRqlXuL6v37OzsHq6krX4Np/JZQyydWNShErrD8Xl
	wJ0cnw1fkBDQZl3KFMKDKWPzzjNMwuTAg5ZtPeWfrWwFprqFEl6UVMUAiUS4CgrRbWPkYH
	pox+fb+1AMpb6oVd9AXGgtnjTGcXnsHh11VQuUeArLyiI0iVU7EbRo0MV9kM8tTmGuqQ13
	sYZlM+EgufRkEmpMppDb3BsUWj3PtiSAApjIBlTWqiTYgb4HuhemNMAUTn7OVO55LDXNFf
	joVY9UgDn0viIcc4zXj5nnMTYMzEJbkohTt9nZHsHYkkbpeTyTGRgoKvJAjGHg==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-8vj2s;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Desert-Troubled: 6e166cee6faafddb_1762857001217_3440765751
X-MC-Loop-Signature: 1762857001217:4042955906
X-MC-Ingress-Time: 1762857001216
Received: from de-fra-smtpout9.hostinger.io (de-fra-smtpout9.hostinger.io
 [148.222.55.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.222.5 (trex/7.1.3);
	Tue, 11 Nov 2025 10:30:01 +0000
Received: from [IPV6:2001:861:4450:d360:3bc5:3dcd:eed2:25ed] (unknown [IPv6:2001:861:4450:d360:3bc5:3dcd:eed2:25ed])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d5N832hrhz3xFP;
	Tue, 11 Nov 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762856996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qfd38hEYraSzh4msAcAjnFoyuX5aFZrJHQNeV8binU=;
	b=Y59Vz5Cy3h7ac5Q4a6xbqQW9AfpFBE0u1er116QmGuyswSnho5MmfyuUgpIXPj9pgYagrC
	IWgn6V6ekxz0t2N6eWIqacQlLy6Ouj10vXWYxU9KJtGWDTLjqOLknF7exzLFUeFydMoSYf
	0Cif2hJwkvmkXaiONmzTnBurJG7yNtq9GxiEmuohXfiK3kLQUErna5kdyTPZ6uAw7nneYf
	4NnXAbKAhsUOvxxze9xRisDZUl29mmsBcOK5Aj0UmdwiOtGZGViUWlaeVuTgOVR4yZGIro
	XUhcGoTUzpEYxOWK814cOmflyCdbUWSEt4IuGJb7ARy5ipVLAznAvRgfFDzgUQ==
Message-ID: <1d469324-84c8-4b5d-ae68-d77e3c822656@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
To: Krzysztof Kozlowski <krzk@kernel.org>, Yixun Lan <dlan@gentoo.org>
References: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
 <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>
 <20251111-inquisitive-ambrosial-chicken-861542@kuoka>
 <20251111101149-GYE1651402@gentoo.org>
 <af7bd4ab-38dd-4a5a-93e5-f457ae3460db@kernel.org>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <af7bd4ab-38dd-4a5a-93e5-f457ae3460db@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Nov 2025 10:29:55 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Ceda56rl c=1 sm=1 tr=0 ts=69131024 a=sEYliDYKNDM94lrOIDkWOw==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=d70CFdQeAAAA:8 a=KNP2rDlw_ukOLo_CF_YA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfN2h32KLALFXb4b0pLM6SFdBF3o6GUHuwWdxBQSw3ik18v2CL3U/G5YljWmpHqb7vlHlv9CPM3OSsJw5V234IDod/ssdQyL+oVsHpxv7dNF9eoqAD4jl qswtwaw5T9T8i3aemvyemMYfMfDLwmQt5Amp02KRqc7L893wVTC6O7ZoV5uh+ZyOPMSayeQkzli5foipfpM9GTNGwiXUH+qxIPns71egEssC5TVNz+En2OmK UX9aE9ZXMDYdxzPhjWoM5953n+fHfLTz0QmsNUzOFkxfU4H+/kyQqw+oVMpSBSgFDT/6AtFPcfbzvKoZOwJx7h/eGp7pPnRstSaqIgQg1hRSuWtWMgOhR4tT hnNcAwi+b5o4a/KE+ZKmQ/ruc6Ze/mwUBzAGaJqnZm1MnclQRCtRcpZsnw0ixiE8t39OAbA/axCKEroDJVVGIP2rOQX+7YrIcgwJewWLMdPKQDfDYzTUP49L PzzNWx4fd+e/XlfN+8UCyvUzyCBk6+WmGVBtkeUCqgYlU4tQBqR/o0qB0cut7nOA9DR3Exty4PqNz127hg9Cn9lasLMFBW2puLuSKLkWbX/O0llzpu0C9vWX 3B+4JU/1R2rFIyelwn2quSse97GglE2bkTW2QvGf+6ZQcXZuHFrLsZAbV+e2zLgNCdE9IDdnKn6AlJWQ5cBNQZGBR/caiAPummppcs6F2R7Vg62sIEUqqyu5 1ZUOC587/Vc9I3vSSJ8R3Kgw9Kmyq/3teBQhQbLMVXTiBznq9ScE/BLk/YuT7kDjuRvupj1Gbt6BDj4O/xOKHuu33IvWlDlh5EK84UMdBwcYHv5sM9N1rg==
X-AuthUser: michael.opdenacker@rootcommit.com

Greetings

Thanks one more time for the reviews!

On 11/11/25 11:13, Krzysztof Kozlowski wrote:
> On 11/11/2025 11:11, Yixun Lan wrote:
>> Hi Krzysztof,
>>
>> On 08:43 Tue 11 Nov     , Krzysztof Kozlowski wrote:
>>> On Mon, Nov 10, 2025 at 10:06:48PM +0000, michael.opdenacker@rootcommit.com wrote:
>>>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>>>
>>>> Document the compatible string for the OrangePi R2S board [1], which
>>>> is marketed as using the Ky X1 SoC but is in fact identical to
>> Maybe, just say it "same" to clarify the ambiguity?
> What is exactly "same"? Same die? Or same blocks/pieces? Whichever you
> choose please make it very explicit.

Maybe Troy Mitchell from Spacemit can shed light on this question.

Anyway, I could use the same wording as in this commit introducing 
"OrangePi RV2":
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch?id=bab8dea259100a99e047fd11a48940b229d30031

"The board is described as using the Ky X1 SoC, which, based on 
available downstream sources and testing, appears to be identical or 
very closely related to the SpacemiT K1 SoC".

What do you think?

Cheers,
Michael

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


