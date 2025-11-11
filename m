Return-Path: <linux-kernel+bounces-895434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789BC4DED5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59484189FC43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572036A01A;
	Tue, 11 Nov 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=struct-network6.org header.i=@struct-network6.org header.b="B3D3cDRY"
Received: from outbound.mr.icloud.com (p-west2-cluster2-host8-snip4-1.eps.apple.com [57.103.68.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A636A017
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864129; cv=none; b=ERlU+z2dEs5BhgEHIaQHkKZ75+VTFahDhMOJEg/xGTLYHTr/VsAi+1krJSZ1Vcvi5l0pNaltgN+yThehs1MxjpSuvBL+m25Bxir0fMcx61hRDe+5LmlvVjNAyrnmSQgXt0nzjirzXgsQCcyMX0x4euuwIgzlCGZSRPO51bx5iVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864129; c=relaxed/simple;
	bh=iqYPLQNVR296qf9EfAo4ucAAeSDYCtrCwjes0607GAw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=iwggrFN/5JoNkPjwUoJHCQmQy0tp42vPAK9dK1P/1AiR86zNNlnz0/qMeUOrKYhfACRzZ+mOIKKOWo9bEXVzykX4u/DyWvQBqC5oJiCrkX7J51U8pzA8/JLAw4nbWrDAKcDMp+2LWGxzTNrlRTQcpCE0LQFA5U/fjR9csQAQ518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=struct-network6.org; spf=pass smtp.mailfrom=struct-network6.org; dkim=pass (2048-bit key) header.d=struct-network6.org header.i=@struct-network6.org header.b=B3D3cDRY; arc=none smtp.client-ip=57.103.68.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=struct-network6.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=struct-network6.org
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPS id 512501800131
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:28:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=struct-network6.org; s=sig1; bh=iqYPLQNVR296qf9EfAo4ucAAeSDYCtrCwjes0607GAw=; h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme; b=B3D3cDRYKP4vdcxwk2EN8UM/Ot1kXmzs+na7CmL/m6UoHGxgm/lhOVxCUnpMTdwZ5go9GB70oSTGhfzXY8S8jw4Jo3xx/6K31h59F4iK+yjDAEQ8raIcrI1NEqkAMOHd3Z/8j29KyioIutY+qIc+21nlCIN+GheomGcBTX9bKngGALsptq7uW9lDkcwU+PW68oev+Q5t3dtc6ooEu0uh5YuP6ZYbW4WyuBa3Dx7/F/EWdDFQAzbgBnptGkKs8pLoD1hf8zeEm1cMNzvctnar2LaUwGPduDPVvqX4uQIfaAwOvIGctNcJLRyYytE56vFk5VOwAcZim8b/20TDVnM8qw==
mail-alias-created-date: 1760900804066
Received: from smtpclient.apple (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPSA id AC7751800129
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:28:44 +0000 (UTC)
From: Adam Addrolla <adam@struct-network6.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Open letter to the Linux community regarding Linux hardware and
 software 
Message-Id: <BA845CFE-28A0-4C24-991F-FBAECE0F9285@struct-network6.org>
Date: Tue, 11 Nov 2025 04:28:44 -0800
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OSBTYWx0ZWRfX0Qp9Ng6tqti2
 nRTlUK+87XHaJZdW4KTzhYVEdCtwjl7RaX2y56hx0yRsjABYPdTts89UUftyC+laSFdK2wlnYhw
 gaH+/MQND0Q4lTddmYTF/lNHPK1vrCGf9tr1qdTiFcUxsLRSZvvHH2jUCLPfM3044WrrCGJNunZ
 G0RJiYa37zU45dTvTKGheC1uaBm9OE1qTMsugdnOUOkA9S5vmUltNiPt4dXNk2FRoeL35z4v53p
 lR+c5D0JGJBjxYMLR3TzdNnF1uvOUc/dsOyY2z5QQIAOfgLRBYFvSgk+c/kcz1+TXvcHGLQit/4
 VKtcfJsReWyDzLsgv+d
X-Proofpoint-GUID: l_9SRP46XJzChL6FOk5BN_OL9N0ZWtNn
X-Authority-Info: v=2.4 cv=M55A6iws c=1 sm=1 tr=0 ts=69132bfd cx=c_apl:c_pps
 a=9OgfyREA4BUYbbCgc0Y0oA==:117 a=9OgfyREA4BUYbbCgc0Y0oA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=OvA30jZ21uQSom0LtpAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l_9SRP46XJzChL6FOk5BN_OL9N0ZWtNn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=824
 clxscore=1030 mlxscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2509250000 definitions=main-2511110099
X-JNJ: AAAAAAAB2gHzRUD72Dd/dZuZcOPwpc3gXxDDlfh+iIEgdX5pZhGx+nNaGqpsPgF+6VAN9C4YRV/id0FQhPZgyDqxdWnsLGStDUiAVo2pyetF8GXVyiRy3BXv8z864SbFs5MoEiW8txja6vf0cUznvv6inrddlfkGWUT+yOOGaOJtQ7nZWVH1YKwnliPhDG7EyG2liH6AcqEvh25cDp2/RTHSGccVzJh4PwcYoBDzwMOWvnf6y3tifTErJAfqoqYQtE0wE9tqdCTFIfjNl7VlTpK6Tng3yHzRBM2wnVeRyBYvX1VTOpWQRMqmw+LO6/klw9mM3hxD70Kz3iDd56uAsxNO12n1z04AujwYTYRllsSUIHTxe/4nfgBXxd3mwGG/RJdk244ZY5DmUZdSjAWwSRAhTrD/ggi20uy0qPKTB1nMeGXdPH60VgqDjwtoCChK8tM0IqpApXUAkZmkizeEDuSn5dlEF93h9R0s1lnYrEtTELAuMAXQaaf6AsFyS44/Jm2XX4rbr9W79DjgvYX5/jE84Q3b5Y+p/q0Jcz4iZe1Qf1E+YvPujPyIlZ8/9AcTt2kXzF3ppmy8L+Bgz2JP0SfITUt5Em44ShQ=

I feel that Linux in order to thrive, not only needs its own software =
distribution model (that includes paid software to support developers =
and software companies); but its own line of hardware, made for the =
Linux kernel specially, for long term use, and catered to other =
operating systems such as FreeBSD, Windows, MacOS, and other operating =
systems, including DOS. This includes hardware such as network cards and =
graphics cards from highly funded, properly invested, and well =
recognized and above all all star winners of Linux hardware vendors.

The reason is, hacking proprietary hardware is fun and all, but not for =
everyone. Now, Intel could come out with their own line of hardware made =
specifically for Linux, but would it really be as sufficient as a third =
party releasing its own hardware specifically made and communicated with =
the Linux community?=20

In order to fully support a descent ecosystem of hardware and above all =
software, especially for desktop use, including FULL Unix like =
emulation, we need vendors that are willing to achieve that can release =
all hardware and software for Linux and BSD

For example, if I wanted let=E2=80=99s say, a Dj device for Linux, I =
could hack drivers and google and stuff, or I can buy a single, well =
made DJ console for a well supported software DAW (like Adour) for =
money, which in turns supports an ecosystem

The open source model of Linux is amazing for its distributed sense, but =
overall it does not have a sound business model for prolonged use, and =
is susceptible to malice=20

So yeah, I personally don=E2=80=99t have the time to run a business and =
support the ecosystem, if you guys want to band together and make some =
kind of fancy RISCV network card and support the FOSS movement and hope =
to succeed in this 2025 tech world, again, with AI and major software =
vendors and competitors, it=E2=80=99d be awesome

Adam=

