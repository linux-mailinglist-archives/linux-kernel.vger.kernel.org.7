Return-Path: <linux-kernel+bounces-740674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72103B0D791
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0B01C2529D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E942E1738;
	Tue, 22 Jul 2025 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NX2lD2yn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1F2E2F14
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181581; cv=none; b=J9minu1/sMxcOes308Uh/tzUSdvqx9Nek1Ro18fUiRYOO8H1mHEXqHZArM7/1Ize/6ulZeOyUxkug2b9HG73aVpwLjcB01afTjPPH88K70Jq6+NB7/+6BImeCNJUkRLif7viNHioUMc9Ca6tLxTRGbQXgLEvIzix2E7ODawl+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181581; c=relaxed/simple;
	bh=YBHibw43npP/3igtkgVtH2Shu8vWib7M9hGwq1sHj/4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ge5ltyaGSFGT70Mqeef7eCfWT5P+Jdp8b8FDKGp04MtwAD20pdi08knSURaEK15cDlsOhC/7RIggkMYWw3VnTGMqdADYNWAL2uhhER4xMMzhqlV7ct5NGortwNw63sdlCujID8ckORksNra4G8yHGVND67TgEhGzoLsAMl0rASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NX2lD2yn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7HhXf015402
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AKOwlZaYbwXHyEej9RpZK4
	E5c2HjPR09ASmbrrQi5AE=; b=NX2lD2ynOP5t7wSNphNnjM6faPUkept2P/qnJ7
	NM0eBESf6baDVAhTP8Axo2UoZ46Uai+N9fFmj66njTd8ljsfuw8pYcNfkmyjdhuO
	WDa2WS9qLctw4ZDMz+eJQhT6j/in9aekX15ehXAJeBTrkYNJapiSd1SpoiVpVVo+
	1yGz6DjaHCW2W/E2RnFv2rUGYK5FKEZTe4OWDTYno8kfCOC6Ew6ct1i7HqXe8IYO
	DNAbwH6wJBBnUqCgb1/yUlyTHgwwGMPMi7uqkRQkDjgiIEBaEeQJZDQfRGmZhI06
	nuuqW30/fpn/h4tXaASmop9iMQfsAeWGMaISJvs+qNbfkrlg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w2935-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:52:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4abc1e8bd11so11949651cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753181578; x=1753786378;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AKOwlZaYbwXHyEej9RpZK4E5c2HjPR09ASmbrrQi5AE=;
        b=Zz78BLO/jfYVSMLm1o1yXPviJWkN81oVq3HHF11Rtl8df0jt5wuGBoGxQeW+o08+Tu
         6Fm04wJawxktfBtgZfsvcXdVICW3nwnlqm8HUUqzkbBnImbJXYrVQWCMTDcpUxGLJ3qq
         WuCBkHNavLoKtDmUDxKDPBAzGe1joES5GQyBmKokDTlXmDG8tNYOWsxT/tMW588TCEC8
         N/8wXLAsFIHOFPAV2XXLDD2PT+zZAJqopYL0mNl0RnNAfs165L2H+uEiyvpjFgQ+WZad
         oc38LHumt6sjyozsAOfw/bXXA/AHYAW5TfZ2MGV88h+DEjxPC7HrIOzKzv+t0O19IWLu
         kRQg==
X-Forwarded-Encrypted: i=1; AJvYcCXI1nSqQEbJGu4diAYuEGkpc4fB7lYU4AVTjwHFKbR13vB03XPbLWZhXVc7QBGzjieaz79l4ZfvZjTFM0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NmGNPkDFWCpPtJZUZV77d2s+q6hxDMnSGCak84Fi9BYreTtO
	4Yl6RH4IxZVybmxY8BA7yKTH+98fZCoFGnyqJSGAbEjY+WWk7vACXL7FtbSrRgXWprWBTlPUkUn
	EbOn6llOX++oZWVQf28zcrPvridjbXl+b38HzZGOl0JYXbg+nUB6jalIoq/jXpvDlMUw=
X-Gm-Gg: ASbGncsOMUKU5AMF6rlaiAUymQsWj52ImkbVsdi8axzxw50avb/H4U6+68aBBreEaOF
	gz/Pm12D6PhcS/+4pbMBrUQJq0HRH2L9TuO6v8a9pYKIxF9fWIk+aH0KCgCPbxJTo2p7cQ4vCGe
	wmdf5DyWOXrOtpTYDTDuInN3OVvk+OhpGVwN68gUC1S+pfvhMMNgWTsMcQz+K1Z1CGLEAAAthx+
	oupVSCvfiCJDPA9hPN+mlGKN6a3DkeWmUL6SGitDvfv/E+4GZxyvwe2UIeRfogVzFhDd/mSmrB7
	8dasHw0QkPFYrJRJg+ZLDzmYEod2VFpsWFUjYFUX0PHJ0ae3S3GydqR6ZShLJhH2t2ghYUTVYY7
	xnd+wiStwv4vjzgv+1jE9
X-Received: by 2002:a05:620a:a906:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e344109171mr1271576585a.0.1753181577465;
        Tue, 22 Jul 2025 03:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC3kHS/EwG1a/Uh43G0nrE+HZkGtHX8kOdC+5yhhb/k2s/vz8XUTk9lB2l50XAAxgVmNU0FA==
X-Received: by 2002:a05:620a:a906:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e344109171mr1271574985a.0.1753181576990;
        Tue, 22 Jul 2025 03:52:56 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d524asm847719766b.45.2025.07.22.03.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:52:56 -0700 (PDT)
Message-ID: <36cdc798-524f-4910-8b77-d7b9fac08d77@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 12:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: make ARCH=arm64 rustdoc fails on a x86 host with SCS enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=687f6d8b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=ERcp8cmLOgnKMofOiQQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MCBTYWx0ZWRfX2ANp+/2i3sfC
 tuZ3R/WPf4M/MOr5FLXEsHCYr9lVwyREmP+PqGZc1Z27bfAx9BKwgTpufMP9Fbnyqg5oRISJg+n
 F9zZIsXf8dpZR0iVHwkCyGJYAyjZGnFE2yyY/K36RYajtwMXko2t5dcG2/3UuAbUwXlL1DkMIaT
 n6g0UDDr7rum/6bKLdKN+ZT0JSdcQ0/DtJH77Z9gK/PNXDnDvI4I7j63O18C0HPrIB3y6DL7VAT
 IMCcfAzdzzaOZhux8868MP+5aMiX6y9cquEG9gCDajnMDY0ZYf9JCzagvidFoXLeE20385e1zKn
 Axbi4gcC8oMllgiAZ0r8X4JKy96tyBiM4i7tu0sA/lYg5s8gcSvvE1PhblIz54glI4F5J/1Bi9y
 /ZhxJ8dbHjNeopdwi8YxFK4KUeq7cAAIfJH5xGu2TDvCqL7rGEqMN4ofsWU2NrtGc34lFfVS
X-Proofpoint-ORIG-GUID: 8XXHOyNLvYp0Sc5o7ueEXy95mo8At3LD
X-Proofpoint-GUID: 8XXHOyNLvYp0Sc5o7ueEXy95mo8At3LD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=713 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220090

Trying to build rustdoc as part of an arm64 kernel build on an x86
host results in a number of errors. Looks like we're ignoring the
-Zfixed-18 flag (arch/arm64/Makefile) at some point in the build
process, but I wasn't able to track it down it myself. Found on
next-20250722 (today).

Disabling SCS works around the issue, but that's less than ideal.

$ rustc --version
rustc 1.88.0 (6b00bc388 2025-06-23)

Error log below (CONFIG_SHADOW_CALL_STACK=y):

$ make ARCH=arm64 LLVM=1 -j24 rustdoc

[...]

error: mixing `-Zfixed-x18` will cause an ABI mismatch in crate `ffi`
 --> rust/ffi.rs:3:1
  |
3 | //! Foreign function interface (FFI) types.
  | ^
  |
  = help: the `-Zfixed-x18` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
  = note: unset `-Zfixed-x18` in this crate is incompatible with `-Zfixed-x18=` in dependency `core`
  = help: set `-Zfixed-x18=` in this crate or unset `-Zfixed-x18` in `core`
  = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=fixed-x18` to silence this error

error: mixing `-Zfixed-x18` will cause an ABI mismatch in crate `ffi`
 --> rust/ffi.rs:3:1
  |
3 | //! Foreign function interface (FFI) types.
  | ^
  |
  = help: the `-Zfixed-x18` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
  = note: unset `-Zfixed-x18` in this crate is incompatible with `-Zfixed-x18=` in dependency `compiler_builtins`
  = help: set `-Zfixed-x18=` in this crate or unset `-Zfixed-x18` in `compiler_builtins`
  = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=fixed-x18` to silence this error

error: aborting due to 2 previous errors
error: mixing `-Zfixed-x18` will cause an ABI mismatch in crate `compiler_builtins`
 --> rust/compiler_builtins.rs:3:1
  |
3 | //! Our own `compiler_builtins`.
  | ^

  |
  = help: the `-Zfixed-x18` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
  = note: unset `-Zfixed-x18` in this crate is incompatible with `-Zfixed-x18=` in dependency `core`
  = help: set `-Zfixed-x18=` in this crate or unset `-Zfixed-x18` in `core`
  = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=fixed-x18` to silence this error

error: aborting due to 1 previous error

Konrad

