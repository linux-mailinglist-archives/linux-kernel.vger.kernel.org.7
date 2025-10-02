Return-Path: <linux-kernel+bounces-840683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6ABB4F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53706325CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68066280305;
	Thu,  2 Oct 2025 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tiSN63eN"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238327BF85;
	Thu,  2 Oct 2025 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432174; cv=none; b=MIeuZtfy2m7/7UU+9nbnT6q4ee0PnTkp8FULF1kgNPox5BXo9Vpn4egG9EmsewPCHqaTwDknr4jtIMgL1eu+9LDUq9Iv7cQ//p19Kr3TTWzzM9kqOGFy/IDa253BzPQEngcYT0ZIdHalR+e/PzgHd3lRNaMJUKxxzlAcYKlII48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432174; c=relaxed/simple;
	bh=rbuK5BnlQIzxUvczpNN8Pk/0PljYS/INkL8ZxjUgV3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTmvyLe+a4XRNgIHF2HkB4/tAs9LBacfhdFmfP3awSA5Mraa6kLz0YwfOW9NLz0jauu41/7lhoJ7bCk6B0VaVqTPFlomQV4w7g3pK0bgV7JFz1FTH4zil5Tj8pFLgdUDW0G3QSg63X145WTZtpBuopsD/S2fw/jUGkJAVWhDZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tiSN63eN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759432164; x=1760036964; i=w_armin@gmx.de;
	bh=rbuK5BnlQIzxUvczpNN8Pk/0PljYS/INkL8ZxjUgV3A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tiSN63eNPnZLCQiu0Qwyd/Vbu9Ue/6BNS5Kd4fz6oUgzFg0Ynenyypg0b05+YG3/
	 R5ROgJw4tbKJTYmzEViEMAA601Y4Lp6IQjbPjgpP3RB09tJFUlFR8W5fOpOgY6oaZ
	 4xUc/qUR7P5857VHMm4TNFbnfCIbXkXUBianNY1t10wR1On5WIKmhmH8ki8+DYs1h
	 WAHGIdPyF8+N/coDZaVIaPgFz5UQupFv064vd9jnExr7xbXUE8IkFYK03DE5wmXlF
	 vBXXqSkzyJswwQ49ZsJOQMzJxtRk89aAvo3N2xGkZ4GpZycUFgDmpomIluvVHaH58
	 PC7gG/1TDlbW+uQM8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([5.61.150.13]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1uaJBL21eB-00qLJo; Thu, 02
 Oct 2025 21:09:24 +0200
Message-ID: <6c0dca8e-cdd3-407b-8dc7-cf5414b37220@gmx.de>
Date: Thu, 2 Oct 2025 21:09:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New co-maintainer for ASUS driver
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
References: <8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LqFrohAeVNl/nnPIcfBY4w/aWJdmtkX7v80YJE01eNcHPbrIfnQ
 l9+Dz9m5gY8381/2QjE9LIH3D5He469/x0Mo4MExu8eMaAo8gK6koHUvoTIgqfW0xps24+B
 X/k6uzhk0s9jlJadBPSsSs66mgTYAve8lyTk6QIJQNBvB95OFLfzg5OMJYxLMgDxL1Q6cEt
 fGyziihexi4p67ZtKiVug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rYPugj5Kge4=;YcyMLFBmbdqZj6iNlG5KNIY3bu5
 V4ZXiAQimjfOah1MikjXo2G8M1fMdFq9tVKVAU6Xe/XIJOFAheiaysVh0wAghCttEuUX1Jov+
 TjHjvNNlCDB8Dj23FiRTBu69oP8rm5Lw6PUU6g82Dp1GwEMTaM3Gaux9wiOlVXthOEqajydc4
 CI5nXgIAWOZu34fnipPtVOC4kx6PYqNNqLvOkzKn2cTut+Zh64LLYJQYM4rgKJJdTjsI4vUKf
 OcaW9ib/RC5iKw8n9tgvoNpPE7KCpTqQSg+DAWNjQtSxZxgMZrpg10F4x0bZ0fwDJePnYct3U
 /9y+Df57Nl7Zf7IOvds3eYyRUl8gdYQkYsq7mA6oK9z0hh70o19Pg1wiKKthd94rIUhFu/o9U
 VG2FXAQ26YSbiV0Tgi30lXv/4mrWDQ2yIj85GUPtWDzGsIHGpnZScEl9yxw+tVwOixX80Mqyl
 BpAx9UicBVUFvBkefRwBP+U460D8bhoeUsJmpboaf+ppfmtBd8po382NywKlS/gvxjoeD2/Jr
 06C45pXGyam8Ct/SkRHsR8gvU+aTWCX0XONdgC/ypp02O99zvu+WFZGFbeISmyTvIviE6P82R
 TiwLv7gw8p7oMpVHyueSaZjwZcElTNUgSWpSF5rPcky1SnwaIavtwkmYt2UXjiC4em4EGbxXz
 /KiUi9OATZHFFKEgfk7pSFugJypiq5MAxTxKVxAYk8IbkDI0FqXtO9tC6vL5tLsbVJt/BleAN
 s0ooBhoonryF9MwH9Gxum/1yTImnziUUYoUmN5AsPNoZs5lXtAgK68BFkkx051LB2lVeFReFm
 n2hM09msFgHsSCkg7EyOM5S8Vx9hqMPHK3RcrCGo0ytViv8Fx8z3MU1z7s0DVXbOTR21v7cs+
 naHg3tIe1w7VGYFFQXKU/GLookexDZfIpNhvGIt0zmjvsNfwgsFzcsF2ARIekCIlPQ+mSaPnC
 hvtTTtdxqqQ7rCGsHiXFi2ne1MW5muuYakMBRUOm2muAz9om3pge2JxYJv3CrKl2Md4I1QE/Y
 rm5CaDSmgqep7oGHNQmCf8zcucxyJD6ZURyszYTRZjgSCLXPG9BBsCUbPQI0h4MxK0yjF5bmV
 ak3fydPxLnA/PDbkZleb9i/VcQ1SibYuo9BT6pmfVX9R1VEVdaL+/tgZVgcokYZL9y2OpKV6w
 s7DBuGb8YGLAUz0ShOBPRwSLx3BRq74qizb3jg7a2dNbKSoNYh4Bu9Y5GG+iMg5gkS35GM4bZ
 iGxLHOuwFatrpKLeZfVN9GiNtgVV0s8D05MKw7erbBTNgE9purTcW4fjX3pS7W/2V2lFx2NPR
 DtnSQHsEg6Na2ZgfpQuJxGSn8o4QtDI5bPJMyEGgZ+hmoQRPasqBY+ogR4fP7gJYNFBiul29S
 0mdvDmtSap+BBoBmiULNksvT2XoRtEqRV/0frZwQwwyEmXR1Nq5tcRqLZXVJVjjuCtpq4Vabl
 YelE9uFgiyA9NGqBqGuQl9DwmX59A2YHK7KtS7H6P3NMTVf0Bom7CbAcTf5IHMGmD0o/dqP+w
 6octF8Pmq5ONPR5dXiox0vEqExx9ay70eaLyyJklwHtVnIFnjvL5MlUsOsps17F9KKfF7HCtX
 /qeBKKxfCcarbGAy9/ZGLLStIEZljKpSJZeNWxlZcK1q3enXOJcpn9VJ/6LD+eqD/ikOkiBPI
 qZTyOWuNHR3Kx2m11GJgELcgtklHSpWyDkFaJumrpK/7px147XTEFXgidMsZg3gihLQqWw5dA
 4lZfajahMYlX30NJ5uscNel7XAUHrP0rpgFbfq+jMQjowc3W9LS9Twx/JBi792haXDGpAHDz9
 TC16uJZt6qV4ER8p0/JdLBFJ1IDpWF/QHwqWhSEmEawKXuaAthdZTZO42pNrsEzi+6tGnbX6q
 FBWC22HOQIXXE9y/9TQkc6bxWyFREt8QR20aDt5vy0otML15tkXlASUNjzS2klxPqJIOBBOnK
 cFJy0KPJ8DkyemL8LLS7rwtVdqCIzySajYrK7DoBNb9X6sv4kGQ7mzCG5Stxnw/JIvTEuuiXN
 X86yi1hsKZdssc6mgVy5yhXJjDO0eQNQajxFSCAblsFMHG46hvZPX9ybrsnHPcjacZ5WZgXCg
 ypp8fIcQAwv0TQNMoTQzcCNccYHKy+rvkdn9UWPFouuAXKFFNNwUUbWutII7jeRhK2t6oZrbS
 pgfEdBU44U+i0oIEGBUsTDkUUNeFb0MBvROo3YkBNgLtz2WqVAkz27u1qx4OdYxJbQE8sFbTZ
 Z1a0dnhnURj1D2RmPl1Sed3LnS/8uFIzyxhXgIIlVMWhxmbb47Lpkyj7fUNauaFoph0Df2jD9
 +qVn+9yp2LxjB8nOckyek6F++6Bjegij0ewP3v/mg4sLBNvhAmrj8PGP1JQys0jxxdkrKp7wo
 QKgMdbL6y63GMHWxpAXvjWmIrTZ1IcfXMLoYSNuWwMXEKDG2ddFMIknPP7TksEuT9+uZKlsqZ
 RKK0nXmQ3oYM8xIWEAFqSYJCql2Apbz7Jc5mRq6Ya1LBpJj7IlqzTjNa8+u9chj7KiA8JHiyO
 jS+Hcwz97nU61MErFxwqcr8zvMJkO4lqYwh/JYaKNEQKAzl8FzmxWcu6br66EL2q1aqZ1IIja
 Rk2VnFX18vcKPS8p7gMCOgUF7lvpNx8o4dQQl5Hwl1aTM8rQXjvBFcfJatm1MVuwBMjnSG2hv
 MpGpOdoKHqdOkIAq4jDeslADWXCDEsh1UiKhd94vt+3UGsVWm96OA+vdU4FMre9MTRTcnAwPC
 0554W2QrFCbEhe+v/56pYL4JHnz6hUOz3kQ5km8Vfj1Cu9cgGYdlp6eaWCw1JzUu1RrGzxXXA
 OeO4k8sSfMttzSzu/vfQSEhoiUAZzSTvCRzrzh4ocMqunqtjtAHsjq6OlsYkNgs0+vlZU2G6u
 X5VAK7TDxqdCsc3bIyqbvR1zxI8VcZols3MhYilZS/OgxAp4T1nPz/c3YS8m0gsNtoLj42UjI
 X9NuIJlHJ1vSUBTKpeV2SoYVFn7/8jCyquL+Q1AQBir4Kejq6FJL+Bktm5J48ob2t0nESvXMc
 E5dYNiHMEEhDPn4MuqyP0ifseAUgH9y2aFet1f67jT9yRGu61degtVGDZ5dYfEv6WAtPEmuG1
 V79jdLekMwH+KKqGqWFeeG83lhNUyI57Q3+xCrcyfqWDsbT1e1ZpeVCSu7dD3AD53ppLRmAao
 6bO9ftPvw1HvusvEdDJ/kbCI3TJAJNdNBoIzsuW7K4RKwgJFbbb4xDRZaGt8EPAx7jLMFH6Ar
 rbidXM23OIY3MfPbEtbRXA0IWiRHjtDWLsq2FE/FZQk0S6DRIc7TVd/M4nU8cZMEQwBKSj7uU
 nukej6Iex3sZISTxVa4fLXqjiH3d9m6HMMvAKr3SSlYFS8kYjnlMYGI/47C0VyG4ZTMTQl49X
 ew7m2eyLU8Mwqo5kyd+dVd6U9sggvj/+6fe8Ya2szlvnGIJKdh7OsxRHbNII38PYLsCvPx0n9
 zdYSqfzYGVSk+dTvuo5/Vfc+vkE626xPdOIN36h0NN6Wzsd1OZrl6k+bhhTXmM4JzaCnMlbOm
 FjVLEo2p05XmIIkxksqUnKuPv95qQiOl4mZVSI/D4iEZWboBiTySztb9xujGEl8a+xNrpLJjF
 vvu7NCRxgA9JwEN8+w4qzGLLEL0/Gi6am7WBa/tVtt3kSdcXrn9STtmwVl6ePGMWp/CfkAuNG
 xOU+XI9JI6Nn54O2OH1e/RPoKrkeLxs9tlZ9NIq+T7v56j6rfKhJQq4L87lHWiwyobMKAvXxn
 QjQ2TzyurAHGeAz0gP0pe3j4WtvkWTzdXDBlWClocBqZkvOVbX1qEEKJj653aUzG7IgAXviMo
 otacZ7bpnhqZp+WuCiqhP9rOETEvTmmmeUkk1GegiBW8RpdnnUKELS8Pf7gHyad/rU3wEolDO
 yHSRjCQx6ONy5IKYMx6FvOsyT/cSmkAbo+60/1Sbk0vOryYZs8jdAa8no/GKgblKXdgG9LmR8
 yXiOY3qAEaAv/pk0xMNkybkjksmEhL07alykUWQxVpMuMlehpLLo+tACizkuOGmPOWhtuOcGu
 lTLXEatZJxBX5ARDrnbBoMSzJGBc8W1uPP+72VeU81wyUlc+nnUmwx6vCfn24ygtPB0Y1ViWC
 qWal/TFC3fnu6XJsn6gqSXBWPgv70Gm77KMi2WDFswIfozGaF6MyHhN/icI6Xk+TTGmr8XDNg
 Tve8smRvfmpocwpPG9CViJkRiFbv3qLdSY0SSSsg68+iQQrEnxurKoWXOiDluh3FYtN+bDhZR
 Kfq1ezWrqE+0xAOmOvZzaxqyywTDcbVoxobh1KGIVNcmcpDGgbaxWzAPyXwWw6s90Yu+REyHS
 WABHZLgJFuwcI3p5MJ7WkFQu83s4C+JYkG85NwO+a3hLsHo6S9VjuMZi38SYYXxpqlxY7yyFD
 E1gK6/Qmr2JFfDtsOUKYzf5PaOmBQSfa2rPuXDj33Omq+/QXuF1CYMyJ4ff9g6jR271+26eWs
 6NmQfgIIvbIJoh+AFndQ0QcdR3XYIeZ24nxgbtBwvHDN9mgg3vuyveqNRg8bxvXdW9eC7LScW
 Ffa7YSWnCJhKm4Id9ZSBB6t1UjH1Cai6l5nlsNKHcjI4p4eMO+pZK0iMQuf8WAAJec8p0tNbc
 o9JYwIZuFV5nWahx55k6JEAdkQTH4il65ebT+WQgX6oLSHCvXDTiOXnDqFFSn30X9HntJdj2y
 ARV+0g6wzLoEbSIYXmLLlXuSUqaLUM5sQXw2wBJdL4nyU34tvRIaAUp8Dc8g+kBx+l9UeCkhL
 Cc4hZS8w7yZq1GLNpsxGp0eR+bwyGVAb6tX5hw/fD+n4ZYjOKSY43lh+M074bWrWbQITM1c9R
 Bs1JKdJs2A4Dd/M07Tz+D7qQ+NoNkd74XVc1wXinftUJPNK9dkudVYYG9Y/KF4ykFHEsg0FNG
 7gOdViDrx8C/+Xl+dbGGV+xl9C1j+SjXMXcWNmGv1Imc=

Am 30.09.25 um 23:23 schrieb Denis Benato:

> Hello,
>
> I am Denis Benato and I have been asked by my friend and person I estimate Luke to help him in his asus support effort and I gladly accepted.
>
> As a first step I have refined his asus-armoury as requested and resent it upsteam [1].
>
> With quite a few more work on the horizon for me, like the hid-ally driver, adding more models to the asus-armoury driver and working on the xg mobile interface I want to ask what's the best thing for me (and everybody) going forward?
> Should I be added as a driver maintainer? Please, advice me on what to do next.

I suggest that when sending your next patch series regarding the asus-wmi driver, you include
a patch adding yourself to the MAINTAINERS entry of the asus-wmi driver. This way contributors
can automatically CC you on patches touching said driver.

Thanks,
Armin Wolf

> Thanks for your time and understanding,
> Denis Benato
>
> [1] https://lore.kernel.org/all/20250813165620.1131127-1-benato.denis96@gmail.com/
>
>

