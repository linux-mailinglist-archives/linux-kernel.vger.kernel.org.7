Return-Path: <linux-kernel+bounces-818228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3490BB58E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2672A06A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725529A30D;
	Tue, 16 Sep 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI5cctT7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53823ABB9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004441; cv=none; b=g4rMOQIBoqcifibEXyCkU8T/hMr662XJDfxjX+9ZmmW7iToyGGLLG6NhGnkIpeuF5Kpi6u7ctw0hzwYY+738RoEgatfJZuUcBFHJIAEplk0DS2Zg7lCNYt0OYYC578xqAlKP0MlzACu+zgN+eeSyQ6wFdPchhgy7iilglsh4WAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004441; c=relaxed/simple;
	bh=fPHSiGAaPFD4xb4FsUoKTayjD83CfWGOCBmUyjIJruY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/PN/NkNeUh+p00cm10EFgh98IiT85d/zIxW7w2Ua4J7pjeH3YO/T2d2Q4FMcZlxc3aAtFqDX00z+xMef/6fQwvR3SwJm2by3aLWcY506GyaS+X9FF7oNB16aRy7pbzAIjZ4X8MmqBUgFtQb43owHHsRbadUyzyb+O00orLX1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI5cctT7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042eb09948so1049774066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758004437; x=1758609237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCcdr8/06mPp/Cx9ptQFN9PXtHrK1LIEHxNLD5oVRjE=;
        b=EI5cctT7CZghMcwUgzKOP2PBUI1pwCeIKp4wlsaU4lA00USPeE3CqLwz87GLhpp9pz
         rzFswRTsVz1eOlfJlfl21yVV11JXD5Ro4vduPDvpLsPKrrJKWwjSrbGEulqXF3l6zwR/
         ZudzO37pEWPReIy2ywVbhUvt47q/HuBprrtbJYisLxK8ByMs23/mypxZJnK9Duqxf2f8
         oIxL3c3Y4hHrYQkgZPttOkEVi+ltN5zBATtOtAgx8nujHtF84p17riIlVXaUJ8klsgnk
         d+B/X9w0hFWLIuip6WTTPxX0TruKmtIMAfl5gKfryS1KkNYc/wjZktgzXonxK3/4uOam
         iLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758004437; x=1758609237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCcdr8/06mPp/Cx9ptQFN9PXtHrK1LIEHxNLD5oVRjE=;
        b=EJtQqo8zbg6nMZq1YnJAUU2f6YKkKSfLiDb4nzp5SBzpX6BlSbHEQQ3pwx8GmljOAb
         2wN5jRhAzU/sbeG8YvOEHKvPDbcunh8xHLqcHKZVQIFTVFM3onbLPhnP5scE4PEvD4Zi
         rSYsAOrrkq4eDVAFImwM15h8tSNgw5pn92y+C9WAbqpu7quE9rp/dm0e30kKCgXVnE4b
         w02rm8Xbxv3iV4JTA/aCh90HKWEt6HA8P2v/JZxHsLtfk9IFJgXGCQl6igMJD+6CeYcq
         Yt+lcioR2o+LfiaV7MsZk6QZQyKmxaVJ6Wj3h8o8cGX0LKnE/Wj6CeU9zwkIXx0Y8guU
         5Qvw==
X-Forwarded-Encrypted: i=1; AJvYcCVOPyBHE+l2BZeMAXVCBcYZtld7bsZ1CRUHei33L4L85dR1cLWB6C8pIris/WBhhAB03RKWDYhjxbIOYeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYj6tdcDTHMFykPYYbwWYV/R2PZRWzXpo7OJOoJyFwoiFC/Rhk
	Pae+2kOc1RDxyYO2PcBtCp+sh2WvO0R7j43PaUQ+wD7KUWriww8j+DtD
X-Gm-Gg: ASbGncs0aZUK2SXtTLmhWw3jvZQn9OrF6NGNn/LCha8OhmCt46WZloJTnybmByktzRo
	M3S9t9zY9dh7Rd8HAk3MheCK7ajpDFlxL4da/bgaQYYMOzp/WeTB+mQDgjygt8aEdjEHnDW2QFN
	THU2PWbhWb+kcKB8FGPBtZQtwBpSDdPswOyuF/EDWAdi5+JSFbez5pmiavOpcpl8J9J4YN0BuKL
	vuafvY5xihuOomXPd2qush+AWA5imcsNICXNOL9C38tUnf6Q9i/digThJa6oNoAsx27cyMAr3Ni
	5A+AO6e12Orl7DAL+NPUW+JcrbQ3FBGPTBxVNUwofTD43G/la0T0va16gNQwZ9gyh/4n3FzSE4Y
	d82LVcoUZMwqPYKvTao45tXyvbDskMlu9MSdl58IScEUYF3cYyLnLh0LGw1mz49mo9Vp3pj1c/G
	s=
X-Google-Smtp-Source: AGHT+IF+fZ0EOPhWKNwezb7QtMcy89tdov+B1kADJASBYm5VpHuWXzP2nOsz6AMpKOBcUuOHQ44Aqw==
X-Received: by 2002:a17:907:7f25:b0:b0d:61a0:9a28 with SMTP id a640c23a62f3a-b0d61a09f4dmr735693266b.6.1758004436883;
        Mon, 15 Sep 2025 23:33:56 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d2870da1sm761043166b.13.2025.09.15.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:33:56 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add TMP110 and TMP113 devices
Date: Tue, 16 Sep 2025 09:33:42 +0300
Message-ID: <20250916063342.4436-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915-undefined-woozy-15e27ca89a36@spud>
References: <20250915-undefined-woozy-15e27ca89a36@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 15, 2025 at 18:18:51PM +0100, Conor Dooley wrote:

>On Mon, Sep 15, 2025 at 08:08:18PM +0300, Flaviu Nistor wrote:
>> Add a compatible string for TMP110 and TMP113 devices.
>>=20
>> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> index 96b2e4969f78..840b5306a8cf 100644
>> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> @@ -13,6 +13,8 @@ properties:
>>    compatible:
>>      enum:
>>        - ti,tmp102
>> +      - ti,tmp110
>> +      - ti,tmp113
>
>The driver has no match data and no compatible based decisions added in
>your patch. Why is a fallback to tmp102 not suitable?
>
Thanks for the review, it is now more clear to me. You are right, the
fallback to tmp102 can be used. My intentions were to be able to make it
clear in the dts which is the real used sensor on the board but this can
be achieved via the node name (or label). Also I wanted to be able to
find via a quick search in the repo, the info that the sensors are
supported in the kernel, but again, I now realize that updating the
documentation and kconfig should be enough. 

>> =20
>>    interrupts:
>>      maxItems: 1
>> --=20
>> 2.43.0
>>=20

