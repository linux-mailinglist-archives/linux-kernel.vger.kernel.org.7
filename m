Return-Path: <linux-kernel+bounces-840694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD97BB5004
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62C919E24D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFCC2848A1;
	Thu,  2 Oct 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kDFcxJjQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02F27B34F;
	Thu,  2 Oct 2025 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433227; cv=none; b=NpRBpWhWpmg8CSJCF2bhuZOLTOELPleZDXR0+ERS+tYe+dv6Zdthjwd6poGAqYO93DxSNBgvXKRubEy41E2o9zdN1HYlpR7TN7kmleZTi9Ex9yY+zo7jbQVzhpQXOTj5JL5OeNRpWmlIUBFXJqFJbvUco43YpAD7SEXCdFnR2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433227; c=relaxed/simple;
	bh=kwynmBGx6WjHx+Ctsh9y8m3TCyLfdHivspaeVUInu9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V28Hfcb0dU5EOxXZoWhTA07fT0EIBAZZszLse8HI5tHsqHthoj30Q3ysj69SiHk88yLC1xvwyTyupjZJKT1ecgcEXf5OW3uJX4TifIn6j7Vby7QLUeNeht2i37QGgEsoCWj2Nr8eNXNJi4f/tz8xMu8j5iTenQoVuK23O5FMhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kDFcxJjQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759433221; x=1760038021; i=w_armin@gmx.de;
	bh=JpCaLjvuYrUaUDtpXtmYSrfUHCO9x7/ssEUOXgWgVhA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kDFcxJjQHvbQXFJshoqMF/QQXvl+y5QPvsOGMoI79LWf/z55XnVwFPSxohP9E6YE
	 HK9LERKJclnADt+gsgBwbo/BNVCMCgce/mo9X7m/IRC2lCptWSyXuyKqj+Z5xCRgd
	 6JpP2YK7L/yKgtpRdwPUuJ6IoZyWl2SrPvc1bDY4rwpzxirg6ZvGVa8IYQtLajmJP
	 n6tPCuOKPIrhlPVceo4Oj4FBMCifJ41G6MVYZ8/RRzKJYDiEqgWTnqcs3qJqDDnFv
	 TYEvwTrB0dUQpYQbjiNfVoHZYTJC8xpihiF6S1B92gpbxpt97fSblbWyZ/dG+HMP8
	 nqpRvIv2EpMmzD+NHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([5.61.150.13]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1umSSk2JOt-00MkLA; Thu, 02
 Oct 2025 21:27:01 +0200
Message-ID: <6fddd622-e270-4cd7-8c36-c656e703178b@gmx.de>
Date: Thu, 2 Oct 2025 21:26:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] platform/x86: acer-wmi: Add fan control support
To: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>, jlee@suse.com,
 basak.sb2006@gmail.com, rayanmargham4@gmail.com
Cc: kuurtb@gmail.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250923215205.326367-1-W_Armin@gmx.de>
 <6218970.lOV4Wx5bFT@cacher>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6218970.lOV4Wx5bFT@cacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VhJR7P+LCuxuKkh00ULKYBXRI1Z7SdNzY1dLlltmhTg/pyN/Tai
 OYJSci2DwAUzEckVqtwxyrgQwpGATYYr5PTSEn7Gp/w4dwVIbEgr2SMiLcTBb4YOz1grkDw
 L8M587wiFgIMr//M9/VMUKy3re5+5T+0hWCrjCOX5UDsSMWSxOLot8QnGQZJBkPCUO0hbzv
 TOulilVg4TYn0V0hgju/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5THdqEx1xRk=;uQBSautjYIi8+V+ReJbZC6M0i5k
 nw8a4khvHF4IYfnldB2hQu1BwbEOuwlYnBzE+WBV/VyoFkM5lXgWajGizsvS8NCTKC4L9J0Rm
 QFj4Ku1HRBXAa4a8X0esc/cD4ZVohpCqcScYKwJe94vy9qw6VpOpFwOJwwuz8amVaK+ffkOHL
 /RwBM1L2Xj9H7/lQkPmGnsNFu4Ndsf7womRZzETIa7PGUrQd9mvzw4JlWI7EPl9eKOu9bqwrb
 hHDtwB7rcl1NP9DX8JJgZdZeI8gdp8XKyIfArhcyL2PTm372XNsH97DQpA1JUm6EMaSHI58fN
 QDBLbrZ7jfZuNI42VvTqTOddylP49/laAUyban8IUBmX4Oc7XH5WMadailoGo4VdXk8VKsmAL
 /FL/QzRU0CbVHFNHoXAz3G0VKW5VyB0aK4wHV0hNC+VAwfPxP1DSkoI130wdbYMnYtXfjxzYw
 ttDSGaY/OqZxavRph7mXO0ykWJXQDwmJgYzZlm3K3IAhzGkxxarZmQhn3/PA2RCrepcVVvDoV
 VISXK7Tx0JhOW92LdGs1hDVr39gFUxVyvWb3ybv8rI+JFviZjRBniL/eViyhcjw/Zjkf5VDkV
 CkV9U9qq4sv1i20LO/reNGfzoR7gTyaroF2waUxKf1j5l8nH2C8e2CsXiAxhE8VD8H9X/5MqZ
 V0hl8TAjQY4XjHcC9GNgwi6pyzB7l0RQYcO6R+1nQJ7xDHHRaZQDm5dN0VEUdO0CIHWNvZe3b
 jb1Bx4dDlt/x+6VbaaKgv32D0UWKAUPnjZLeDIXBTuDVfo2rb/ck1Nsqp0WXgiEneMg0ivJHx
 MNcju87QpBpDAkowxomu0ImNeFiszAv+K0K6JinYV0fYGX97+SG80+tc7tHR2qBYOj2cHj5NL
 LewMRfy9tMNS6L8wbeC92LV4VRY8J2rJYKR0J5+ds2VWAG2u78GIxqSNMKSe7GbdA3dVtWY5f
 dytstQJmrVTegyD2nvX4v3mZMWHwcKhnyOVYzHAi3a2HeXt/9nITNwU+5K9g/zMwjqaK0WPtK
 OwcdkNA+YnQ09Ee3TBjlpYJpoTjMvQEUuhXcowljpD2z+e5rRn1lq32vFkv1gByfr60/Ax98k
 T9PL47xm3GSmgb0/cu5AUkE4tYSYkmAOwG2BbC+0LFGm7/9RhiyhZxp3gIfPmXeZi/GnkWeM+
 tar/d0e2IpTjck5AFaNzLW+ReXuo5T1j+k1dchWF33NBGLfE/e2iUNNJsAjyWEEZCdY8I78CQ
 9+zurp4r6TJBBZh432HwSYEL3vN9EcmDD+scyWMTpeQBJ5l4MS28+yPckXV2tMagPcQGw3xFq
 96ZKbpDFBq56Nw3S/80Tc82M27gQpC3pmVc50yGryCNFuxi3Fd6Orz3w7O1Zxs5RPop0Xxy9s
 onuaeJffGFbu6xrKg0wMTnIo60HCPb/xRLVUAd1BD2QSAgVVzrGwMiwEj8ERr1W/zovK07Dfu
 /TyMr/XPdq78yRrOYvw63fQy3v2lEhEdXc21FfovxgIXEB4Hf48x+2xbGB73+RqgTQOyIl3oi
 irj/BZJJ/VaXrzmnqiq70gk5A4rVC3bPYYxe3xA3aBOHBbI01tEpOAGlL+t2/pl2JqAx6mDOf
 6No9I+KS8paRtTNKWDralxErtw4SL6z8/TEPiM3QItnmRoPLRF39UPIuJQVoqKgGCYXhQJy8W
 z03O7rdh+IXWgUWWVbwdDiJOngPmd7b+JrBQO+wyEvMlEdgonSO2Uwrm8k3mfV5EIDxWythq8
 qvfjpO0YjiZnHKmQOAptnKdTYaWFOf/zoyfqU/Mfdwh8s6PVzXYHMG37uVMFH4rMlgI82L86V
 LyrAcewlI2hx9TzcuPyxuIk03X5+24bI5lQEyE/dUx+4Epnq1Mx7uusPeP80kD/DDXNadUnoK
 X/awsfRhCrER7qiIZNRLCA31tbmHUshjycsY5bVQcGYtqMr16V0ELDguhbDzNZnjg4hIhBZ1I
 iiYgx+0+XuMRdWUo5gRm0Knw2GttpgMCUCSpx/XpmeZlg7pNd+aZZ9KfFINguVtX45v0OKC/o
 MVdHKFAXEpX8nTXoGF+EzV2MtJqLzOU6RLfa5EsYI9/77W5R9lAS2x9J3IRx0KAPEh2GTkrD/
 7MdKLeOBnFMyqbF0tPs+mD126zEeZ4VSXf029GpTa5ncGaAZfW4dcC2eVOmxxs36u1K1MVmS8
 ivZWGHFuzxLJiAWf3F58dL5v58gV3vpD4PhPFgFu4eKlgPsE54vmbc1UP/JfWRL1HfIfTRGZb
 hefWxBOZgbItBqRVfn6HOvc2kVEw6clRenPu2E/gKdqzYj1Vdhgza+CLjiB8DMsnT6I/btaMS
 6+opj+aY3BxS5a+GW5dvKglK2FJ8dxNxfQJruKXd3HnraJqvUQpCtlKYgWESswTulDvBS43l7
 ok+DIwxUqAYrHTYtArI87fRjPNVodwwSm9o1+4N+/NCbMDkZPJx9J30RRCxLOoTc5Aa+bagPx
 rTkbAk3lTp5U9Vb1vXLgKuOT70hluAuym3wMLoKgDi8+16SgEFJ6gOFLgQbqsQBKLIWHAEhUW
 T0PqtDkyEy1Kf4iVMMPFcZPpmKFLSwGAvFP8KdKetYOZ4LMY2WEDXl6+OKF0KyB+aQRjHfmXe
 wFlJBDYFzskcglGeCGE1bhP2ylo5GMZyneUz1iIQoqxRnaFDlkMM9KdE8x//HdefufaooXtg2
 h5FteJz7xTnulWUcP9geTjucY0WAPmMP5bbSIOWcDsvRiGFOUrzW01tmtkl9h4vQGArnkumYU
 ggdRfjqU+uSXndWdn534bnIIu55JKVovoJwFkv/ElGEWhfDF0QwguNfuLFiuGARaJMxyuRqkL
 RodKkuDq6rO0Hx27H7pbMq41ZV2Ig1sKuSKUGRa+mCqJKEGw2N0TfdaFSn8DuaXwPBIyUCwUr
 vRSzytqc1wLw2iMuaoJ07jIb/9uewYPjOxZvNGSAg+WQyHgETzCxzACvbdLn2LFg4km6CPWP+
 clNeqhIRBVzbYik45yU7wkzyTYgzJrLqF6v3lxJOJB5vyZuyXhYt1XVlZe3Bbcbla1WB53G8y
 hhijfjqOPFks7/SXieoFyp4hRMdgzXr/bIRrsjbU0wqObP4SbXyAW+WoaEwUeKUSTLjLJ5xNA
 d4V68vKeeFrC63sllwRKPKrkPGbNToYoEAN608U8W3yfa2PUu1a3YzKHNDI40FyjYXkeKAtEW
 NnR4LoGvsjzb0tKXd7GJ7Rn0DRnPjf6BqO5rN0gMK0LCfYNVOVGyLvWWdytjMkPlA4LxWPj/m
 EPtciigQvOMe+XMqmOMC31rOXXa8nqpm4nFf9UuwzjF7AX/EIbemLS1H31Sx+v+9Lgz3kpQpQ
 DcXsQTem4ZJmNZTBj08YcqVfLivC+u9776k44lgiTaoXc4Hoa50UpQ7w4fjevCZjrB9cco1ip
 Q57N5piMT9TdN5EBHLuySM2CvCkvzfxp1PN16/argEZ7Z+oRNwAuqzgo50GfDMMAJLyPDUMDO
 ltUIr4GYBgjJTTRyLk0qa+jfkyRPb/7lrRBXRy6ZF6gEiiQwVlH/kyZtApxCmW5Z90bI+ajry
 x8pAX6+Ev6NyCjhkXEpe4q+hbTgplr6xdkc38FxTy1NuJpS2PtcWmpCPxn9e7TaKtr7VBc1DU
 4R/yWb48shrDNMArQMHL6kH/Weh1Kl/d1x2aMqrdkBNcft+8pxzmaGWzbcaYKFUWeOzT8Cb9G
 Zs+p4J9ZBejfM1lghFIvHDnh9o3H1sC2jiXS1s8CA9wdQEYfatVw2iWIKKTJNRBi6oMcqRLcC
 fJPoSRHXKEVXkbWSNLxfa6s0inlxW3g62OdKSf3Vg/WpQJvF7N0qborDc15Tonts/vIRUrxFV
 tfpSjgVknyCuuN8X/fqUFOZ+vIujfxBT0TEEbdEwh3DFhgthYPhljDIIFqAHMYBL7lu/d5V85
 K0ekPxhTO2kVybN133ZSOg6CdYssKejMbcnmbxnT97pucwRkqN5ky2eXkiPl5Qf6bTIrXX36U
 Znwh4sU5cRvIi2tdQmCZGzBUEj2kHLPpu7FfY20IvSGX8bt2WcXw7Ld+5oQsxS46CYi+K19BS
 h2V4k1R+JJ65IjaftlezYxHe/+kCrxHKoeX0ANHEsj0aGeHF+aIeP6D34pPs6ZZUS9pGhhF03
 mjB5KbNOJ1OWb7E5ZQ85OF70Hfwy0+0ICtLB1kF/htQ78SjglWcTynq+Q6a3HceJB6eOhNng2
 c30QYVI2CuHo1Xl60z4Gyl0OfWYxiOk67md+OoWDnngQlVZtk6fnGpka1oNAga9QBj36xxDg/
 B3vpFXIauGoHGxbPC/KbnQhYwWeljhLfAqPYLDvWMPVZanmOu40DLwY8+MDwv2/tdEGIUcES3
 jZXXzcJb5oLBYILGG8J8YNSvJxzvTI0tjG+Um5TKOufVRRAXehWDyKKxrsN5VjcFObCcJtwJ4
 2YNCOK/OpoxZOpG7ylFR1Quj0M4+z0efNFfiq9l4ZbRAs3FwfSSUaSUs5mghHtKarBUhqe1Gu
 VGJWkFyTK3kDpWCUk/w5+vl9CUCYW5MeFxwnwqSnt6QKRqUw2i+ZquQzdkyhmwbpVnAy2W3R3
 MK4KH/0WdjJhigX01UsCyprb+H9uoJ7it+4APKGsP0X+AFT46Tvpav6oznHtFQY0DD4qbEgc8
 BLybyFuHyowtFLkikVuBkqBjJ9lIddkB0692fS3MjUpkpV5F+BNwV4abp4vefJhC9LuZ0vu7N
 uvPKuNvkVsz3A8/O4g8DB7ymhhttxSrE66zWXAh1Kj3R2ThUyOuNsOuXlLk/N+XmgLwBtqxiQ
 gfVPOdlWrGrJ1B/JdxVOsHa7Q9NwDejPIMpyD2Ypzao0JAmgeHpi+GtNM4ym6WqEsV8joVj5u
 Nof791XVtzyzic4TU33uwoqBnnpFHIdB9Y6uqitZYoN18/Nf+uKmbmvqM1VjUDbcdDLYoxqjA
 CR+lLJ08dON3IbgSmuyhS45NWw1xkheD5neYtP0ppKaEPBHRjoqalAJHaQNeSfQ1b+MvTr7wC
 Don0IKIyINovINNv16Xf85O84/Psp2fm/3yG2zSJWveC1C+c9V8WgOgM

Am 29.09.25 um 04:04 schrieb Fa-Iz Faadhillah Ibrahim:

> On Wednesday, September 24, 2025 4:52=E2=80=AFAM Armin Wolf wrote:
>> This patch series aims to add fan control support to the acer-wmi
>> driver. The patches are compile-tested only and need to be tested
>> on real hardware to verify that they actually work.
>>
>> I CCed three users who requested support for this feature. I would be
>> very happy if one of you could test those patches and report back.
>>
>> Changes since v1:
>> - remove unnecessary blank line
>>
>> Changes since RFC v2:
>> - improve error handling when setting fan behavior
>> - Add Reviewed-by tags
>> - whitelist PHN16-72
>>
>> Changes since RFC v1:
>> - remove duplicate include and replace hwmon_pwm_mode with
>>    hwmon_pwm_enable in second patch
>>
>> Armin Wolf (4):
>>    platform/x86: acer-wmi: Fix setting of fan behavior
>>    platform/x86: acer-wmi: Add fan control support
>>    platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>>    platform/x86: acer-wmi: Add support for PHN16-72
>>
>>   drivers/platform/x86/acer-wmi.c | 308 +++++++++++++++++++++++++++++--=
-
>>   1 file changed, 283 insertions(+), 25 deletions(-)
> Hi,
>
> I've tested your patch on my PHN16-72, Fan control works just fine, and =
it does
> detect my laptop properly.
>
> Thanks,
> Fa-Iz Faadhillah Ibrahim
>
Thank you, i will send a improved patch series in the coming days. I would=
 be
very happy if you cloud test those too.

Thanks,
Armin Wolf


