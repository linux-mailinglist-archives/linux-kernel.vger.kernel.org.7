Return-Path: <linux-kernel+bounces-658791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD90AC0749
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437F73B094D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C074272E42;
	Thu, 22 May 2025 08:38:59 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA826A0BD
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903138; cv=none; b=PYG6noKG1579tNiXFc3OkXAyKMsaJppIxujMN0W8QZEwkAhF3VCiLYr18XIe9nYj64qibL/Wp6Hg4JckU1L7XHaJqn3Zox2SqcZTPmfnjAoaQvx6yEqSdwVqyRA6cXfurUo7/KQds6+SIKDmQwFSzzTQN1R8Pj81tEQAZ+mUAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903138; c=relaxed/simple;
	bh=ECMYCLI/ObPefuYL5Hqvb7e8k6VvXooWcI5CkM24C3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufZ+cO1ip9KyH0QsH9CjWx9alqUMiTz7XNLArlBiZeFymQnhXcFMdjqIk/8BJxCQURib7p9s+UdlvskJM9yLfu+KshwExRQmk8ComE862657xQaZ5oNiByUqNSFvH1spzgKXTamv4IGBlGswoKmjO9a4V0UdXIAc2a8pmwVBooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201622.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202505221638412659;
        Thu, 22 May 2025 16:38:41 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 May 2025 16:38:41 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.039; Thu, 22 May 2025 16:38:41 +0800
From: =?utf-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?=
	<liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] erofs: support deflate decompress by using Intel QAT
Thread-Topic: [PATCH v6] erofs: support deflate decompress by using Intel QAT
Thread-Index: AQHbyvGRgY5hMCky9Uqppe0YISlvV7PdzKiAgACGaWA=
Date: Thu, 22 May 2025 08:38:41 +0000
Message-ID: <3bab0dfa463743cb92b56e20ffe55af9@inspur.com>
References: <c5129488f0303e9b3544ab995500c4a522-5-25linux.alibaba.com@g.corp-email.com>
 <c4829613-1fea-488d-9d58-373e0d3b6bc1@linux.alibaba.com>
In-Reply-To: <c4829613-1fea-488d-9d58-373e0d3b6bc1@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0058_01DBCB37.A0821100"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
tUid: 2025522163841745fd774eb8092f15146d8a35c497a6e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

------=_NextPart_000_0058_01DBCB37.A0821100
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Gao Xiang <hsiangkao@linux.alibaba.com>
>Sent: Thursday, May 22, 2025 4:34 PM
>To: Bo Liu (=E5=88=98=E6=B3=A2)-=E6=B5=AA=E6=BD=AE=E4=BF=A1=E6=81=AF =
<liubo03@inspur.com>; xiang@kernel.org;
>chao@kernel.org
>Cc: linux-erofs@lists.ozlabs.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH v6] erofs: support deflate decompress by using =
Intel QAT
>
>
>
>On 2025/5/22 16:14, Bo Liu wrote:
>
>...
>
>> +
>> +static int __z_erofs_crypto_decompress(struct z_erofs_decompress_req =
*rq,
>> +				struct crypto_acomp *tfm)
>> +{
>> +	struct sg_table st_src, st_dst;
>> +	struct acomp_req *req;
>> +	struct crypto_wait wait;
>> +	u8 *headpage;
>> +	int ret;
>> +
>> +	headpage =3D kmap_local_page(*rq->in);
>> +	ret =3D z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
>> +				min_t(unsigned int, rq->inputsize,
>> +							rq->sb->s_blocksize - rq->pageofs_in));
>
>Please fix the alignment of this line.
>
>Thanks,
>Gao Xiang

Sorry, I will fix it right now.

Thanks,

Bo Liu

------=_NextPart_000_0058_01DBCB37.A0821100
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
MAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcN
AwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBTkHdp/y3+DuDJ13Q1YzgU9iV7N
dzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8GA1UdHwSCAQYwggECMIH/oIH8
oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIsQ049Q0RQLENOPVB1YmxpYyUy
MEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aG9tZSxEQz1s
YW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb20v
Q2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEEggEbMIIBFzCBsQYIKwYBBQUH
MAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERDPWxhbmdjaGFvLERDPWNv
bT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBh
BggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwv
SlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNydDBBBgNVHREEOjA4oCIGCisG
AQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJsaXVibzAzQGluc3B1ci5jb20wDQYJKoZI
hvcNAQELBQADggEBAA+BaY3B3qXmvZq7g7tZLzq2VQjU//XHTmyl58GLDWdVHsuX3lrAGwEfLVnU
odpvthjtb7T7xEUzJh4F62zLFSm8HOBPH1B+6SFQKChHZeM0pauvXr1krRtVv82RgLsU26XrXFUP
N+NcPwt7vOw1zHOiDic4anL3A9gsuDljAi2l+CA5RY05yL+8orasEAhOYL6+ks9aB8QiCxbZzShk
DTMkrh0N1DjoBLaibtnlI/fxOUYM6vgdiI+FC02G41B364ZAc1mabSFvGIP6cIdr/olprPQOj9cq
6zMi05qUBUj22hDvhcY0TlT4fEJSrvblp/LG6qTtVI3ilUAxhe8i9cIxggOTMIIDjwIBATBwMFkx
EzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT
8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHVTGwIT1/wiwAAAADR0TAJBgUr
DgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA1
MjIwODM2MTFaMCMGCSqGSIb3DQEJBDEWBBQbDexK/2pduA7TpPXOwsh6ZPZo4TB/BgkrBgEEAYI3
EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEU
MBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHVTGwIT1/wiwAA
AADR0TCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJ
k/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1D
QQITfgAA0dHVTGwIT1/wiwAAAADR0TCBkwYJKoZIhvcNAQkPMYGFMIGCMAoGCCqGSIb3DQMHMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggq
hkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB6q6Zq5W1oPrF/bcMLyvGx4Q2p7+VUnKHocNNg8ZD0JZ8kKwR6
FyqdIXUbxfvca6M9zV0AYnnmn6bDuv+VR+prQB6fSFQuM870F76mN0l0P7RdNAj0gaEbE6YZLt8e
aHsGWThqCov26bvr8zNxFXuX9tt3avUj1dhcwpgyYlrG0nqr3Vdbzr2mLs6O/+pZOWWV2UGK9djU
bpcmCpyXOhK125ev0DSIeKnsOZbp+vxpQkuiC51LH0sB1N+3nnNvNu+2AVhJsWvjUdKp5/cbn3lZ
x+oiPA08KpOiBO4aRGNngczoZ9ys23iBt6mdm96TrNoH9fZwFwUeaEjm8mjQswM5AAAAAAAA

------=_NextPart_000_0058_01DBCB37.A0821100--

