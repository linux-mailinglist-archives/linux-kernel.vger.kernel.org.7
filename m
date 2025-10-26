Return-Path: <linux-kernel+bounces-870670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45764C0B6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F34EE914
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304AC2FFF9D;
	Sun, 26 Oct 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="P11Wu+Jq"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C92FFDFB;
	Sun, 26 Oct 2025 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519857; cv=none; b=MZSlGOJjII8MphyVFRTcgonxtx1ci1JZBJ6aRpLdFMkdCWb7aFvzQThjBUFYPhIrLqIN+1IWi/y5ieAPiNOHu6NlE4wK5B/ieZnP2NJyN5x3c578QMkdnzS9xnJbdlkhIyvBCpGrOtGUdl5u4pxb7w4AibRH3eCZ5oN473CGAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519857; c=relaxed/simple;
	bh=spmY8XzUGDUBFK9i70+/2eIOOfB/YH2vNjELCNv9Ci4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA9ZkHKIuATCb4KgW091DvJzo0bdIqvz8BdXfJBbrUpD3gZlC6gUi+zT1Ybt+af0D3dlHrv0BzQjqbNAAVdKkGPEO7rx7kPnNJvdJEBbCPYUinHfKXlXvmWvd27DCOV/qz+1kZmfDBIQAOlU5JVrlBDHR4SqOy4YfoVfQIBAs6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=P11Wu+Jq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761519851; x=1762124651; i=w_armin@gmx.de;
	bh=eM4yzMsvkYmqYB9MYjOfBFMICmpLmwJdpXF6ZlLVUg8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P11Wu+JqvxCGd5iRubif+zIDUcnXOscIIr4EBzp7w9r3Us3/JJIf7a1XRfF50ee/
	 aj8CVxpMsNxtpnbs9nzpJyAlA68f3W54CFSMW4k216r/CCO45GMSUW/cPvXwRYxWQ
	 TyfR+4IwHzPpJzx3MBeZ56WuEmy6mzf4JLU+JElQAZd9jB/xUdSGOizCcWCE5jToJ
	 bivwjaorusMEuYGH/b/LfTEI2izC7zSRItVf6MDmk+h++hoTaF/DG4sg5r7b/0g4w
	 6WpKwTnn09tPVc9N/yMdMv5tOzVD2uFcFpa1yoT1DM/7bqZJdoGpkkZr2uVPc3cpM
	 8guo2chNe7fCt0RIqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1vC3qw2HaO-00GOHc; Mon, 27
 Oct 2025 00:04:10 +0100
Message-ID: <4ed5435a-a35f-4794-8d05-2cc0e34538d7@gmx.de>
Date: Mon, 27 Oct 2025 00:04:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] platform/x86: lenovo-wmi-other: Add HWMON for fan
 speed RPM
To: Rong Zhang <i@rong.moe>, Derek John Clark <derekjohn.clark@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20251019210450.88830-1-i@rong.moe>
 <20251019210450.88830-5-i@rong.moe>
 <CAFqHKTkOZUfDb8cGbGnVPCS9wNbOBsiyOk_MkZR-2_Za6ZPMng@mail.gmail.com>
 <d498a1ca58eac5689dae68fffc29440ba75a5faf.camel@rong.moe>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <d498a1ca58eac5689dae68fffc29440ba75a5faf.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g+bzT6ir4BcKXZxnd4Gk0NM/kghFTxXXf8L5KOpxp2N7gk5Seu1
 7qQjXUV0mCJ9Dhk06M+IrSkQgYKVVsQJNsoAiztomlCNCblZfUs5R98UPIHj4s+94xZ1MKw
 x5ObaL/ls17EGEssTrsQzGp2UeYSQrm53knLqiPJarqQhN8jmplivbRiBPI0qH+rNatMoQP
 9NpJoNoOQ6O6UO1N6Rp/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5ziBZ8blvlo=;VfcD9mkG7bowzHYlRlHtJTRUEaC
 R7Y0Ik6BpBwrTtx+mFzm3+x3FuHet5gZ1mA5TxHS7BjBlT53nquxoDNCKtOrZXcByL68U9UOc
 PsvKFa3nuQnjTiCV1Cyl4ipQrZsB6qCjJBl/NZUF3vagRK/vV/YDdW1wViWYBmydqwGunB3bp
 AWSQxUeYmTdPJMTaUGe0FCrQIXar1xFqe+AENn7TC1NreUwZzfQTttL/j3iDkoXxTnA6e2oMU
 8i0MmJ3P7kkG4BQz74Y2Brrz4L0ElUZvlZGXKP+7oi9vMsDykkENhf54V3eR1DjeVaGatUy4e
 UsQRfGoYDr4UFoftAPJTcmAMqefqOxezldbuZGtFosq2AUlXYhusM2T3zWHtN9QOU06YnPkjj
 VJLIwQEPvGEDfnE2g/ild4MYTurdd35VvtKBJpLywoaeJ43IuanJBYvlHQng7HVQkUlNq9q5c
 Gaf/9cM7oLUOAWv3Wubs1StVCot1Vrk/D1Nb2Sca8U5D/OgJSS/B0gfr2QxbpRuAN7qsNxHHv
 aaLZ6/zZUiv9vmV43bwvz2UR/752GtRcYPdqSHQoegiGxYB9bgwgscxSFUVyB2oX77tDAVztA
 sc7bfzJ/tkwU6P6gsT5+WzqtJxMHcz2KeBV+owNelaUhFtl/V6L4oACHahpmMihfBiAEyY1Ow
 Krivt/jBl0wl7KlHKG5uOYobqMIre3AsimpASvNFhjL8+GTf3+MCkes14kxgm9JgGx2+08XPk
 ha6h06fSyt6WUzBmq++825tv3ZxUsIyCLxIAF2L2YaiCvhepp3XQIa++74ucxeE5hjVYa/vct
 af7BVW7h32j5FN7Lk8EA1rA9DmHDAgzbv6Mz/8yzq33xmmFL7ZVY9NslS2Al0i6c21YIuFD3K
 VNWUaCDEElEEEPbx5wDe1hjOg2Axye3ZhwWnAs9hRSyNiMz9KNXnFRrB7cOw+Dyh3nT8sI1h1
 3xj/CdFgjM2ZBlfP5S3TMpsVqKabeyHByc0UtCwrQqbwsqrgUWX8wMMRxWA+WtDgqLoQNAWRJ
 /HYPTYJIcOs6OaFxg8J5XJxxNsLoJLVW7f0sw86Jixy1gLWd/ktuIhPT7bqnwW7M+tQUEN4R/
 +0ZKeRYgQI5agkN1FTd+/gTX1iUi/bw9Z3uYceYW9uP3GVcBitUTMb2mYrMO9hwx0Qn4bSmi5
 ZL+bZzcsTOwuu+WLwj4kCbDUOIUXjsBxD3YWE3mszZt8zbFm3SJtZLmvSdA339Y88StxnY/dv
 KB6TABrs6a+iG5V2rYwDyoYmCRJha0LpgQVxTcQxIIW/kNHIlChLerJW5a04Bo8TLPknMt5aO
 1Y2Ee7M+jb/RXLMdc+OZ5zhUYYlKVXgeEu9ZPRVGqLpV3zzKJOGJAkFuygcxyQcmAEwe13m87
 JbPUVbg1Tlq8E4yJjKXIpx7lej1OKJRgC+gsUGyyMrFpNXNs/R/DSIRZgT6/3bdf6fTz1adUY
 Fi+TAZwCzh6fPtzHM+Gg7XGdZoZj3dX71rF4pXLp5DtoX9YWf2ECFbltEMUQ7Xiua3UO/FS4d
 Gji9Dg6n3x6HcdBoWnT7wvCQ3KHJVSvBBGHxZqyk7kFNFysZrlkbGQEKMVxuHRs891Tc/94Qg
 G8S/PRkHGXsaxQ2L77c4f+UtKOIfe0MiVxJln+ORAlEtHQvHACSbs53pEX5Swy0x8kJzJt7dK
 x3Ymit+Rr0WfKdzEc4giMmUUBcTgHU9Wsc/vMpRkTlrsi4wLYrGv75kBx9jj9gdraP0IdQUyX
 a4xkDsVhEZEqO95dh8ZVkN5+Liera8x9Epx/f0Jf4AnJ4wIbDfJKh8mhE9UaVMs2/kUumBabZ
 0t3tiEYlT8s8tu8Mu/ckB6sesmfjEzhhwstetZEHBrvh56P8YOzeyO1hWPkFFteJrOODPgp5b
 BOQD0zjtaC4DPqYIR0MkuYaaoyFP4/hRNVVz1G98gBDsnPMw3Qdh9lKRU/cfMw/njn30L08Vf
 FH30B5u8or7iQFvJyQs5bgU468TbEEmk+da5oqP5NOfYaSvaNiE/bcJyl9h644T71uSKg+BRD
 Qzj3rC+pr6mb1kZOEEJCN9dwAdkxm2XXac1cI6DFua7wTgfL72SGoWlP74U5I7pKMh/AVFKJk
 AS+IBph3tA7Dul4KlEilBIkraguTG/bvtwcNKMmLqpWnOTRB29TaliJCT5W6E+CAiB6OyGQkn
 la2EM4TndSuaJDLkN+8T6GWEQiuyQaFzAhCJaZrw3wIXddAwQh0YI78HzP8FTWfdkCCMcoLoi
 zSIeX1LVJmnZDImQNOWiKEF4YBH6NTg98G3kn82sKM1W6ICjXgjJJFVxyn9sWTEs1sxbq45TO
 xhUy8xqnXLPXi2TPkDHj+w9BQ93bs7H+YjFjPTL2ZGWXeS9L+E7792dq8zeQhByPs21zFALw2
 bRLx0gwIDgzQF0cU9peGXcYPtT1/KZPeE7k32X20bFUMNDELrFDrgUM7/kOvANZwcZBlX4qf8
 ZCLVsi2nbSmQRfDp8iHeIWdVRhdiYE3rdtF1hL34y744bdV3ByIJE90p5GZkquQoTORto6n2i
 pyZj35a4Num4M4h3mAZ8eT7jv4oieCI3I9jhTZbevomEVH0XCLvp6j0c0XDujNLTVb6LrZMUQ
 BDn9ju6niecjXoaua2ABZcSZBDjUeSSiA6G7DHu1rVytbMc8D5P9cB8FH+D/2K8njX96Ntz1S
 +Lg47lWbRyjtCXGgNSwsXoqa0D9jgHYrBLws/6A4YgJPdjGxnO0lbaIs6D/DbCA5Zn9ohgoWN
 WrIh+YfWKqArnShQctKg3qGBpw3d2Ryn/3LyH0z0O3JRjqJKw82ZTABGZxt4RY/Yk++abm5tR
 IquSA0uewS9y3vlVUilr23CP2nV9g8i2l3aiQg728fKjJzzapf+NdNp7jRHmZkQ1kCLiTttJV
 FJ8mqX+Fit4MwORnhrptglIQNKEE7VHlC6fdWfJTvJOiI8rWjJxJcz+06iLvt9vzJ9SSUlAwV
 7pl7xl9swISuMfHDzMvcFkeVs1G1JXOAoPN9LQXHdy/pFBHRdcmhrnMb7mFW27ZkFFOK0DIWk
 sPF/dcJrlWtnBp9S/Wny2pXOl1lU0kG1+eKVfydtmfJ3dNYTrRg6IZesZGuSyytfEbo0Ll8dv
 ilY+IZLGVqfytXCROeawIMkH/WbGcwa6f8PsccTaQ+snS93jc5w9kTO7hnjjUysjfVFhNesFC
 SSOfrKCSAHLHjiKohfmONpDtTa0HkOzZ2Qv3bgv8Dj02JYcxLWK5/ZzRJWxg3BmY7WBnhQEka
 cFD9CHW/7JLLNjXQekASDX8FTx/ny7pceMeb32TrnhbxZIJAhI4SF46/VKyp8E5jUtxzUPFid
 /SDd+bYF6n2fk3eZtAjnseDaWuBuQxKC+IirlmMrK+Y5Aj86Ynw1WYHoA58+IDiDVdH3VuuRt
 6lL8p3jyjzD+sJHFkpMcYp4detAYu5NgjIOMK6yRX6pmD1cyHgNv0EGL8fDhNGSZ0N3htOl1x
 uA03uU2wPUlqhQsXMMS6tI2Dej+nBLznJERsyd9X573e0oFdFe0skxaUKnu8D3eXfg07yc9Po
 XtQux1kb01SJj4kEX5L6PK7NjuovxUg4jrCONNo1CXYmZX4pSt3G06NHNP2i3MzddILXNfE6E
 V45zBncCEau2UULnXLLPKXkASYi+2v1znNR5NS5Y7EHvd+sv4/zaZfwrWXprLyIEL169ClFfG
 9xUf+gb1c+rGSGCz4buC35HLLTpgdphqQsM9J9v80YBtfshRxHZK8ld2h3sxVBtUG/mDQpdL0
 ZeJ/s9j25u11bO4+Sna/+ucf0HAxo2zy3HpS6u0FpbSyL4d9YS5G9wkc4E4/wTM8dxePDyqI+
 fqSY7PGPAgmccvfEmcMHuBMxjYCZOh5ImHGi04c2sv5ESSHBJWpeMSccsZ6bSmR4OOhsjRjws
 iUUMN/d0twC5Oh8tubkucUiEoXNIgQTLRgVL1nL6hhl8jaWFS2jr+zNmW2Bvge8+Y2Nkca5mf
 u+o6JYtpq/WKjgEBiaPe/9zir40iP//VOM0IXL9GtNBtRY0EN55qPI0h6PzgGabTr3v9GDGN1
 gFBe9JSEVNXYBaGjN/MlLxqBJPu3c+e0wfUh2X87CYLwztSiQD5IGjTSWgWF17QLXZDP/Q6Mg
 +MD6GvmomBM4NtsHX50GXgAvxoVTzZ4X04iXwV/OV49xTEWQo4lgVAEqDVCRcdfm+Rj54YCjO
 +npNvO3g5Rs4CGoLDlpO0/MYfduUkydYtLlYqbwcgLp7YiJle3/WfBCr+C6rGpiY/ftC2iVLB
 71z2QEZ/mAMqZc5LHlL25JtHHuIw0SnHlbD8aIgFOtmH//Yr/AftZHJAESvUMiOJ2IJc1LEY9
 5uSyQOQxcNrfal4JBJH4IzIiiSRGl4xV/DBxAUg0H5sG+zmIbwXlPEoAd5j2PNE1YKwZI0QX0
 bnOST5+RuG35R1Z97lfKrSrIY5GGOeTEbjwyXLzCApQbJCsQevgrv+CT+IddlUwh7XYGX//Jq
 MARHLcIv005HEb5E+TDYgr4/hytAxgoXCo0JlicW+Z0V9gb+gw7236S09cqZsQXO5ZL9MHv0G
 JphbkFibouOwNTY9L0nMrj5h3I9T1jvHqG8FfYJRFbwi2wg294t7J0b1FFzjCAuicS44FR4/L
 +iL/nAK3dSEvMzsR9dtOcn6gv5AdA4AVCZtYPX5mzQVgN074Ku6KGvbi871Z2YV95Lx2RFtmI
 b4fyDCqwU1RDyRVEHCcEZCLN9eJNrfIn6sqQ/hACYK2ux+FTrLHHOaaKuANJ55mAY6u9/rD2T
 QbBBjjDQ7SDmmrbyvslyPZw++o+/ULs3brtYiAiJ1pH3cEjXNOTYpxJUcMb99d/CRDDQRPMD2
 YxmKcD0SbSSE5zqbdPGVpK0OyAUVxBaI0SqyuGYr3WhzrURibSmz/g1skodj6SoTjGvLcC1oy
 se7C3xw49cdypiGk5wYPq0QPN5/b5htaPgK1yePXQCxAbv/wU5L8rLqroN2UcovRu+0VHl/Ok
 S3kLA8uoCvWwLzxHcXqahSj87BYbLFsiXzF/NJo4iqMNs/hSFmLTJ8p8pikfRT5HJIcSb+iUT
 1LOTPACa1vR14Up71VmCuoqsjT03IvyKVRUniGwgToo8+ViGT/9c3xz1FDofCyPWDFUkg==

Am 26.10.25 um 20:42 schrieb Rong Zhang:

> Hi Derek,
>
> On Sat, 2025-10-25 at 22:23 -0700, Derek John Clark wrote:
>> On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>>> Register an HWMON device for fan spped RPM according to Capability Dat=
a
>>> 00 provided by lenovo-wmi-capdata. The corresponding HWMON nodes are:
>>>
>>>   - fanX_enable: enable/disable the fan (tunable)
>>>   - fanX_input: current RPM
>>>   - fanX_target: target RPM (tunable)
>>>
>>> Signed-off-by: Rong Zhang <i@rong.moe>
>>> ---
>>>   .../wmi/devices/lenovo-wmi-other.rst          |   5 +
>>>   drivers/platform/x86/lenovo/Kconfig           |   1 +
>>>   drivers/platform/x86/lenovo/wmi-other.c       | 324 ++++++++++++++++=
+-
>>>   3 files changed, 317 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Document=
ation/wmi/devices/lenovo-wmi-other.rst
>>> index adbd7943c6756..cb6a9bfe5a79e 100644
>>> --- a/Documentation/wmi/devices/lenovo-wmi-other.rst
>>> +++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
>>> @@ -31,6 +31,11 @@ under the following path:
>>>
>>>     /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attrib=
ute>/
>>>
>>> +Besides, this driver also exports fan speed RPM to HWMON:
>>> + - fanX_enable: enable/disable the fan (tunable)
>>> + - fanX_input: current RPM
>>> + - fanX_target: target RPM (tunable)
>>> +
>>>   LENOVO_CAPABILITY_DATA_00
>>>   -------------------------
>>>
>>> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x8=
6/lenovo/Kconfig
>>> index fb96a0f908f03..be9af04511462 100644
>>> --- a/drivers/platform/x86/lenovo/Kconfig
>>> +++ b/drivers/platform/x86/lenovo/Kconfig
>>> @@ -263,6 +263,7 @@ config LENOVO_WMI_GAMEZONE
>>>   config LENOVO_WMI_TUNING
>>>          tristate "Lenovo Other Mode WMI Driver"
>>>          depends on ACPI_WMI
>>> +       select HWMON
>>>          select FW_ATTR_CLASS
>>>          select LENOVO_WMI_DATA
>>>          select LENOVO_WMI_EVENTS
>>> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platfor=
m/x86/lenovo/wmi-other.c
>>> index 20c6ff0be37a1..f8771ed3c6642 100644
>>> --- a/drivers/platform/x86/lenovo/wmi-other.c
>>> +++ b/drivers/platform/x86/lenovo/wmi-other.c
>>> @@ -14,7 +14,15 @@
>>>    * These attributes typically don't fit anywhere else in the sysfs a=
nd are set
>>>    * in Windows using one of Lenovo's multiple user applications.
>>>    *
>>> + * Besides, this driver also exports tunable fan speed RPM to HWMON.
>>> + *
>>>    * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
>>> + *   - fw_attributes
>>> + *   - binding to Capability Data 01
>>> + *
>>> + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
>>> + *   - HWMON
>>> + *   - binding to Capability Data 00
>>>    */
>>>
>>>   #include <linux/acpi.h>
>>> @@ -25,6 +33,7 @@
>>>   #include <linux/device.h>
>>>   #include <linux/export.h>
>>>   #include <linux/gfp_types.h>
>>> +#include <linux/hwmon.h>
>>>   #include <linux/idr.h>
>>>   #include <linux/kdev_t.h>
>>>   #include <linux/kobject.h>
>>> @@ -43,12 +52,20 @@
>>>
>>>   #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B=
"
>>>
>>> +#define LWMI_SUPP_VALID BIT(0)
>>> +#define LWMI_SUPP_MAY_GET (LWMI_SUPP_VALID | BIT(1))
>>> +#define LWMI_SUPP_MAY_SET (LWMI_SUPP_VALID | BIT(2))
>>> +
>>>   #define LWMI_DEVICE_ID_CPU 0x01
>>>
>>>   #define LWMI_FEATURE_ID_CPU_SPPT 0x01
>>>   #define LWMI_FEATURE_ID_CPU_SPL 0x02
>>>   #define LWMI_FEATURE_ID_CPU_FPPT 0x03
>>>
>>> +#define LWMI_DEVICE_ID_FAN 0x04
>>> +
>>> +#define LWMI_FEATURE_ID_FAN_RPM 0x03
>>> +
>>>   #define LWMI_TYPE_ID_NONE 0x00
>>>
>>>   #define LWMI_FEATURE_VALUE_GET 17
>>> @@ -59,7 +76,18 @@
>>>   #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
>>>   #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
>>>
>>> +/* Only fan1 and fan2 are present on supported devices. */
>>> +#define LWMI_FAN_ID_BASE 1
>>> +#define LWMI_FAN_NR 2
>>> +#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
>>> +
>>> +#define LWMI_ATTR_ID_FAN_RPM(x)                                      =
          \
>>> +       (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |      =
  \
>>> +        FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) |=
  \
>>> +        FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
>>> +
>>>   #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
>>> +#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
>>>
>>>   static BLOCKING_NOTIFIER_HEAD(om_chain_head);
>>>   static DEFINE_IDA(lwmi_om_ida);
>>> @@ -76,15 +104,256 @@ struct lwmi_om_priv {
>>>          struct component_master_ops *ops;
>>>
>>>          /* only valid after capdata bind */
>>> +       struct cd_list *cd00_list;
>>>          struct cd_list *cd01_list;
>>>
>>> +       struct device *hwmon_dev;
>>>          struct device *fw_attr_dev;
>>>          struct kset *fw_attr_kset;
>>>          struct notifier_block nb;
>>>          struct wmi_device *wdev;
>>>          int ida_id;
>>> +
>>> +       struct fan_info {
>>> +               u32 supported;
>>> +               long target;
>>> +       } fan_info[LWMI_FAN_NR];
>>>   };
>>>
>>> +/* =3D=3D=3D=3D=3D=3D=3D=3D HWMON (component: lenovo-wmi-capdata 00) =
=3D=3D=3D=3D=3D=3D=3D=3D */
>>> +
>>> +/**
>>> + * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
>>> + * @priv: Driver private data structure
>>> + * @channel: Fan channel index (0-based)
>>> + * @val: Pointer to value (input for set, output for get)
>>> + * @set: True to set value, false to get value
>>> + *
>>> + * Communicates with WMI interface to either retrieve current fan RPM
>>> + * or set target fan speed.
>>> + *
>>> + * Return: 0 on success, or an error code.
>>> + */
>>> +static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channel=
, u32 *val, bool set)
>>> +{
>>> +       struct wmi_method_args_32 args;
>>> +       u32 method_id, retval;
>>> +       int err;
>>> +
>>> +       method_id =3D set ? LWMI_FEATURE_VALUE_SET : LWMI_FEATURE_VALU=
E_GET;
>>> +       args.arg0 =3D LWMI_ATTR_ID_FAN_RPM(channel);
>>> +       args.arg1 =3D set ? *val : 0;
>>> +
>>> +       err =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, method_id,
>>> +                                   (unsigned char *)&args, sizeof(arg=
s), &retval);
>>> +       if (err)
>>> +               return err;
>>> +
>>> +       if (!set)
>>> +               *val =3D retval;
>>> +       else if (retval !=3D 1)
>>> +               return -EIO;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +/**
>>> + * lwmi_om_hwmon_is_visible() - Determine visibility of HWMON attribu=
tes
>>> + * @drvdata: Driver private data
>>> + * @type: Sensor type
>>> + * @attr: Attribute identifier
>>> + * @channel: Channel index
>>> + *
>>> + * Determines whether a HWMON attribute should be visible in sysfs
>>> + * based on hardware capabilities and current configuration.
>>> + *
>>> + * Return: permission mode, or 0 if invisible.
>>> + */
>>> +static umode_t lwmi_om_hwmon_is_visible(const void *drvdata, enum hwm=
on_sensor_types type,
>>> +                                       u32 attr, int channel)
>>> +{
>>> +       struct lwmi_om_priv *priv =3D (struct lwmi_om_priv *)drvdata;
>>> +       bool r =3D false, w =3D false;
>>> +
>>> +       if (type =3D=3D hwmon_fan) {
>>> +               switch (attr) {
>>> +               case hwmon_fan_enable:
>>> +               case hwmon_fan_target:
>>> +                       r =3D w =3D priv->fan_info[channel].supported =
& LWMI_SUPP_MAY_SET;
>>> +                       break;
>>> +               case hwmon_fan_input:
>>> +                       r =3D priv->fan_info[channel].supported & LWMI=
_SUPP_MAY_GET;
>>> +                       break;
>>> +               }
>>> +       }
>>> +
>> There is another method in capdata00 that could be useful here
>>
>> Fan Test For Diagnostic Software
>> uint32 IDs //0x04050000
>> uint32 Capability //9:by project
>> bit 3: 0: not support LENOVO_FAN_TEST_DATA, 1 support LENOVO_FAN_TEST_D=
ATA
>> bit 2: 0: not support SetFeatureValue(), 1: support SetFeatureValue()
>> bit 1: 0: not support GetFeatureValue(), 1: support GetFeatureValue()
>> bit 0: 0: not support fan test for diagnostic software, 1: support an
>> test for diagnostic software
> The information is useful, thanks for that!
>
> A quick look at the decompiled ASL code of my device's ACPI tables:
>
>     Package (0x03)
>     {
>         0x04050000,
>         0x07,
>         One
>     },
>
> I've confirmed that the corresponding ACPI method didn't modify the
> return value of 0x04050000.
>
> 0x07 means my device supports this interface, GetFeatureValue() and
> SetFeatureValue(); but does not support LENOVO_FAN_TEST_DATA. Is BIT(3)
> only defined in some models (but not on my device)? The data returned
> by LENOVO_FAN_TEST_DATA seems correct and is probably the min/max auto
> points.

Can you please use this information instead of wmi_has_guid() when matchin=
g the
components? I would prefer if we can phase out wmi_has_guid() eventually.

Thanks,
Armin Wolf

>
> My device didn't implement {Get,Set}FeatureValue(0x04050000). What will
> it do when it's implemented?
>
>> I'll discuss below, but it seems like knowing min/max is a good idea
>> before making the sysfs visible.
>>
>>> +       if (!r)
>>> +               return 0;
>>> +
>>> +       return w ? 0644 : 0444;
>>> +}
>>> +
>>> +/**
>>> + * lwmi_om_hwmon_read() - Read HWMON sensor data
>>> + * @dev: Device pointer
>>> + * @type: Sensor type
>>> + * @attr: Attribute identifier
>>> + * @channel: Channel index
>>> + * @val: Pointer to store value
>>> + *
>>> + * Reads current sensor values from hardware through WMI interface.
>>> + *
>>> + * Return: 0 on success, or an error code.
>>> + */
>>> +static int lwmi_om_hwmon_read(struct device *dev, enum hwmon_sensor_t=
ypes type,
>>> +                             u32 attr, int channel, long *val)
>>> +{
>>> +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>>> +       u32 retval =3D 0;
>>> +       int err;
>>> +
>>> +       if (type =3D=3D hwmon_fan) {
>>> +               switch (attr) {
>>> +               case hwmon_fan_input:
>>> +                       err =3D lwmi_om_fan_get_set(priv, channel, &re=
tval, false);
>>> +                       if (err)
>>> +                               return err;
>>> +
>>> +                       *val =3D retval;
>>> +                       return 0;
>>> +               case hwmon_fan_enable:
>>> +               case hwmon_fan_target:
>>> +                       /* -ENODATA before first set. */
>> Why not query the interface in realtime to know the system state? That
>> would avoid this problem.
> My implementation follows the approach of corsair-cpro
> (drivers/hwmon/corsair-cpro.c). hwmon_fan_target is about "how much RPM
> *should* the fan reach?", while hwmon_fan_input is about "how much RPM
> does the fan *really* reach?"
>
> Calling SetFeatureValue(0x040300*) sets the former, while calling
> GetFeatureValue(0x040300*) queries the latter. IIUC, using
> GetFeatureValue(0x040300*) for hwmon_fan_target violates the
> definition, especially when the fan is in auto mode.
>
>>> +                       err =3D (int)priv->fan_info[channel].target;
>>> +                       if (err < 0)
>>> +                               return err;
>>> +
>>> +                       if (attr =3D=3D hwmon_fan_enable)
>>> +                               *val =3D priv->fan_info[channel].targe=
t !=3D 1;
>>> +                       else
>>> +                               *val =3D priv->fan_info[channel].targe=
t;
>>> +                       return 0;
>>> +               }
>>> +       }
>>> +
>>> +       return -EOPNOTSUPP;
>>> +}
>>> +
>>> +/**
>>> + * lwmi_om_hwmon_write() - Write HWMON sensor data
>>> + * @dev: Device pointer
>>> + * @type: Sensor type
>>> + * @attr: Attribute identifier
>>> + * @channel: Channel index
>>> + * @val: Value to write
>>> + *
>>> + * Writes configuration values to hardware through WMI interface.
>>> + *
>>> + * Return: 0 on success, or an error code.
>>> + */
>>> +static int lwmi_om_hwmon_write(struct device *dev, enum hwmon_sensor_=
types type,
>>> +                              u32 attr, int channel, long val)
>>> +{
>>> +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>>> +       u32 raw;
>>> +       int err;
>>> +
>>> +       if (type =3D=3D hwmon_fan) {
>>> +               switch (attr) {
>>> +               case hwmon_fan_enable:
>>> +               case hwmon_fan_target:
>>> +                       if (attr =3D=3D hwmon_fan_enable) {
>>> +                               if (val =3D=3D 0)
>>> +                                       raw =3D 1; /* stop */
>>> +                               else if (val =3D=3D 1)
>>> +                                       raw =3D 0; /* auto */
>>> +                               else
>>> +                                       return -EINVAL;
>>> +                       } else {
>>> +                               /*
>>> +                                * val > U16_MAX seems safe but meanin=
gless.
>>> +                                */
>>> +                               if (val < 0 || val > U16_MAX)
>> I think it might be prudent to only permit these settings if fan speed
>> params can't be known. Pragmatically it ensures userspace is aware of
>> the range of the interface. Per the documentation it should be "safe"
>> as is, but setting below the min fan speed will return it to "auto"
>> mode and the hwmon will be out of sync. Anything above should just be
>> set to the max, if the BIOS is working properly.
> On my device, the data returned by LENOVO_FAN_TEST_DATA seems to be the
> min/max auto points. The fan can spin much slower/faster than the
> min/max RPM. Setting below the "real" min RPM stops the fan - setting 0
> is the only way to return it to auto mode.
>
>     # grep . fan1_*
>     grep: fan1_enable: No data available
>     fan1_input:2200
>     fan1_max:5000
>     fan1_min:2200
>     grep: fan1_target: No data available
>     # echo 800 >fan1_target
>     # cat fan1_input
>     800
>     # echo 700 >fan1_target
>     # cat fan1_input
>     700
>     # echo 10000 >fan1_target
>     # cat fan1_input
>     6500
>     # echo 100 >fan1_target
>     # cat fan1_input
>     0
>     # taskset -c 2 stress-ng -c 1 >/dev/null &
>     [1] 37967
>     # cat fan1_input
>     0
>     # echo 0 >fan1_target
>     # cat fan1_input
>     2200
>     # cat fan1_input
>     2600
>
>> IMO the fan speed data is essential to ensuring the hwmon interface is
>> usable and synced. I'd move that patch before this one in the series
>> and make the 0x04050000 method reporting IsSupported required for any
>> of the attributes to be visible, with value checks against the min/max
>> when setting a given fan.
> I agree that setting the RPM too low/high may results in HWMON being
> out of sync, which is usually not desired. Will=C2=A0do these in v2.
>
> My extra idea:
> - drop the parameter "ignore_fan_cap".
> - new parameter "expose_all_fans": does not hide fans when missing from
>    LENOVO_FAN_TEST_DATA or when 0x04050000 reports unsupported.
>    0x040300* is always checked to hide missing fans.
> - new parameter "enforce_fan_rpm_range": defaults to true, checks
>    against the min/max RPM from LENOVO_FAN_TEST_DATA while setting
>    target RPM. dev_warn_once() when it exceeds min/max RPM.
>
>>> +                                       return -EINVAL;
>>> +                               raw =3D val;
>>> +                       }
>>> +
>>> +                       err =3D lwmi_om_fan_get_set(priv, channel, &ra=
w, true);
>>> +                       if (err)
>>> +                               return err;
>>> +
>>> +                       priv->fan_info[channel].target =3D raw;
>>> +                       return 0;
>>> +               }
>>> +       }
>>> +
>>> +       return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static const struct hwmon_channel_info * const lwmi_om_hwmon_info[] =
=3D {
>>> +       /* Must match LWMI_FAN_NR. */
>>> +       HWMON_CHANNEL_INFO(fan,
>>> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TA=
RGET,
>>> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TA=
RGET),
>>> +       NULL
>>> +};
>>> +
>>> +static const struct hwmon_ops lwmi_om_hwmon_ops =3D {
>>> +       .is_visible =3D lwmi_om_hwmon_is_visible,
>>> +       .read =3D lwmi_om_hwmon_read,
>>> +       .write =3D lwmi_om_hwmon_write,
>>> +};
>>> +
>>> +static const struct hwmon_chip_info lwmi_om_hwmon_chip_info =3D {
>>> +       .ops =3D &lwmi_om_hwmon_ops,
>>> +       .info =3D lwmi_om_hwmon_info,
>>> +};
>>> +
>>> +/**
>>> + * lwmi_om_hwmon_add() - Register HWMON device
>>> + * @priv: Driver private data
>>> + *
>>> + * Initializes capability data and registers the HWMON device.
>>> + *
>>> + * Return: 0 on success, or an error code.
>>> + */
>>> +static int lwmi_om_hwmon_add(struct lwmi_om_priv *priv)
>>> +{
>>> +       struct capdata00 capdata00;
>>> +       int i, err;
>>> +
>>> +       for (i =3D 0; i < LWMI_FAN_NR; i++) {
>> There is an assumption here that isn't accurate. Each fan ID
>> corresponds to a specific fan functionality. 01 is CPU Fan, 02 is GPU
>> Fan, 02 is GPU Power Fan, and 04 is System Fan. Not every fan needs to
>> exist, so an ID table might look like this (example from docs):
>>
>> illustrate=EF=BC=9A
>> UINT32 NumOfFans =3D 3;
>> NoteBook:
>> 1: CPU Fan ID
>> 2: GPU Fan ID
>> 3: GPU Power Fan ID
>> 4: System Fan ID
>> UINT32 FanId [1,2,4]
>> UINT32 FanMaxSpeed[5400, 5400, 9000];
>> UINT32 FanMinSpeed[1900, 1900, 2000];
> Thanks for the information. My device only defines 0x0403000{1,2} in
> LENOVO_CAPABILITY_DATA_00, so I assumed LWMI_FAN_NR =3D=3D 2.
>
>> In such a case, "count" would be 3, but the idx should be 4 going to
>> the hardware because the GPU Power Fan isn't present, while the case
>> fan is.
> LWMI_FAN_NR has nothing to do with the actual "count". It is about "how
> many HWMON fan channels are defined?" It exists because HWMON channels
> are defined statically - we hide defined channels when they are missing
> from LENOVO_CAPABILITY_DATA_00 (and LENOVO_FAN_TEST_DATA, if
> available).
>
> The implementation of lenovo-wmi-other doesn't use NumOfFans either -
> it queries LENOVO_FAN_TEST_DATA using fan ID directly. NumOfFans is
> only used when lenovo-wmi-capdata retrieves the data.
>
> This implementation has another advantage: the X in fanX_* is always
> the same as the fan ID in
> LENOVO_CAPABILITY_DATA_00/LENOVO_FAN_TEST_DATA even in your example
> where fan 3 is missing - fan3_* is invisible, fan{1,2,4}_* are exposed.
>
> Given the information, I will define 4 fan channels in v2.
>
>> Thanks,
>> Derek
> Thanks,
> Rong
>
>>> +               err =3D lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_=
ID_FAN_RPM(i),
>>> +                                        &capdata00);
>>> +               if (err)
>>> +                       continue;
>>> +
>>> +               priv->fan_info[i] =3D (struct fan_info) {
>>> +                       .supported =3D capdata00.supported,
>>> +                       .target =3D -ENODATA,
>>> +               };
>>> +       }
>>> +
>>> +       priv->hwmon_dev =3D hwmon_device_register_with_info(&priv->wde=
v->dev, LWMI_OM_HWMON_NAME,
>>> +                                                         priv, &lwmi_=
om_hwmon_chip_info, NULL);
>>> +
>>> +       return PTR_ERR_OR_ZERO(priv->hwmon_dev);
>>> +}
>>> +
>>> +/**
>>> + * lwmi_om_hwmon_remove() - Unregister HWMON device
>>> + * @priv: Driver private data
>>> + *
>>> + * Unregisters the HWMON device and resets all fans to automatic mode=
.
>>> + * Ensures hardware doesn't remain in manual mode after driver remova=
l.
>>> + */
>>> +static void lwmi_om_hwmon_remove(struct lwmi_om_priv *priv)
>>> +{
>>> +       hwmon_device_unregister(priv->hwmon_dev);
>>> +}
>>> +
>>> +/* =3D=3D=3D=3D=3D=3D=3D=3D fw_attributes (component: lenovo-wmi-capd=
ata 01) =3D=3D=3D=3D=3D=3D=3D=3D */
>>> +
>>>   struct tunable_attr_01 {
>>>          struct capdata01 *capdata;
>>>          struct device *dev;
>>> @@ -564,15 +833,17 @@ static void lwmi_om_fw_attr_remove(struct lwmi_o=
m_priv *priv)
>>>          device_unregister(priv->fw_attr_dev);
>>>   }
>>>
>>> +/* =3D=3D=3D=3D=3D=3D=3D=3D Self (master: lenovo-wmi-other) =3D=3D=3D=
=3D=3D=3D=3D=3D */
>>> +
>>>   /**
>>>    * lwmi_om_master_bind() - Bind all components of the other mode dri=
ver
>>>    * @dev: The lenovo-wmi-other driver basic device.
>>>    *
>>> - * Call component_bind_all to bind the lenovo-wmi-capdata01 driver to=
 the
>>> - * lenovo-wmi-other master driver. On success, assign the capability =
data 01
>>> - * list pointer to the driver data struct for later access. This poin=
ter
>>> - * is only valid while the capdata01 interface exists. Finally, regis=
ter all
>>> - * firmware attribute groups.
>>> + * Call component_bind_all to bind the lenovo-wmi-capdata devices to =
the
>>> + * lenovo-wmi-other master driver. On success, assign the capability =
data
>>> + * list pointers to the driver data struct for later access. These po=
inters
>>> + * are only valid while the capdata interfaces exist. Finally, regist=
er the
>>> + * HWMON device and all firmware attribute groups.
>>>    *
>>>    * Return: 0 on success, or an error code.
>>>    */
>>> @@ -586,26 +857,47 @@ static int lwmi_om_master_bind(struct device *de=
v)
>>>          if (ret)
>>>                  return ret;
>>>
>>> -       priv->cd01_list =3D binder.cd01_list;
>>> -       if (!priv->cd01_list)
>>> +       if (!binder.cd00_list && !binder.cd01_list)
>>>                  return -ENODEV;
>>>
>>> -       return lwmi_om_fw_attr_add(priv);
>>> +       priv->cd00_list =3D binder.cd00_list;
>>> +       if (priv->cd00_list) {
>>> +               ret =3D lwmi_om_hwmon_add(priv);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>> +
>>> +       priv->cd01_list =3D binder.cd01_list;
>>> +       if (priv->cd01_list) {
>>> +               ret =3D lwmi_om_fw_attr_add(priv);
>>> +               if (ret) {
>>> +                       if (priv->cd00_list)
>>> +                               lwmi_om_hwmon_remove(priv);
>>> +                       return ret;
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>>   }
>>>
>>>   /**
>>>    * lwmi_om_master_unbind() - Unbind all components of the other mode=
 driver
>>>    * @dev: The lenovo-wmi-other driver basic device
>>>    *
>>> - * Unregister all capability data attribute groups. Then call
>>> - * component_unbind_all to unbind the lenovo-wmi-capdata01 driver fro=
m the
>>> - * lenovo-wmi-other master driver. Finally, free the IDA for this dev=
ice.
>>> + * Unregister the HWMON device and all capability data attribute grou=
ps. Then
>>> + * call component_unbind_all to unbind the lenovo-wmi-capdata driver =
from the
>>> + * lenovo-wmi-other master driver.
>>>    */
>>>   static void lwmi_om_master_unbind(struct device *dev)
>>>   {
>>>          struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>>>
>>> -       lwmi_om_fw_attr_remove(priv);
>>> +       if (priv->cd00_list)
>>> +               lwmi_om_hwmon_remove(priv);
>>> +
>>> +       if (priv->cd01_list)
>>> +               lwmi_om_fw_attr_remove(priv);
>>> +
>>>          component_unbind_all(dev, NULL);
>>>   }
>>>
>>> @@ -624,6 +916,9 @@ static int lwmi_other_probe(struct wmi_device *wde=
v, const void *context)
>>>          if (!priv)
>>>                  return -ENOMEM;
>>>
>>> +       /* Sentinel for on-demand ida_free(). */
>>> +       priv->ida_id =3D -EIDRM;
>>> +
>>>          priv->wdev =3D wdev;
>>>          dev_set_drvdata(&wdev->dev, priv);
>>>
>>> @@ -654,7 +949,9 @@ static void lwmi_other_remove(struct wmi_device *w=
dev)
>>>          struct lwmi_om_priv *priv =3D dev_get_drvdata(&wdev->dev);
>>>
>>>          component_master_del(&wdev->dev, &lwmi_om_master_ops);
>>> -       ida_free(&lwmi_om_ida, priv->ida_id);
>>> +
>>> +       if (priv->ida_id >=3D 0)
>>> +               ida_free(&lwmi_om_ida, priv->ida_id);
>>>   }
>>>
>>>   static const struct wmi_device_id lwmi_other_id_table[] =3D {
>>> @@ -679,5 +976,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
>>>   MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
>>>   MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
>>>   MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>> +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
>>>   MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
>>>   MODULE_LICENSE("GPL");
>>> --
>>> 2.51.0
>>>

