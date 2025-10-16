Return-Path: <linux-kernel+bounces-856423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F61BE4230
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AAF3B1C68
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D5346A08;
	Thu, 16 Oct 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Uvu6OzjT"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3B3451CC;
	Thu, 16 Oct 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627303; cv=none; b=GttYjYHnl00ecwSEhg06R47ocJn/fBaiY36LtPzFx651DGyyLsReqOFTAFb68ZTtDi68VdwdTzGB9J8pB1F69vu96sD4SWYgIXHZ0Fy3+nma4FuJAv/EWqvUd2jT12TZRhIK/GZuUSIrNnpJ4OWwnTcjkX0QY8qTnXfHFi2Ne2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627303; c=relaxed/simple;
	bh=Bhhsv29N8UT2rTO98AuGMOntvyU3hzFZ1ai1AGnWL/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uvn+ZVVvd2Sz3z00hKy7ByHECC8GlVyTmmlaZLG3+gZNGf+QugcV4BaxMgbeo0KPOw+ghimpqmhnTs8k36dLdX0tV+VpvlGnqFiUkQisJgU8DCzOGs24y22TC95KrecnTw4P+VFYmRDucl1vD4w8g2iZqi2o5UcBzUeWvnWW0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Uvu6OzjT; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760627261; x=1761232061; i=markus.elfring@web.de;
	bh=Bhhsv29N8UT2rTO98AuGMOntvyU3hzFZ1ai1AGnWL/o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uvu6OzjT1j/zruuvTtCnekoIPJuV6+DanMy949Ljvi8+CsAfNma9a2fRXZRYOhHR
	 XmYOSKrJGBGQAL9PissjvXf5ZnkdVipXGQXK88MeREdXOaDLzW8zonWSMSNZwoJxo
	 wtkVU1ydVWtLDq9Tbfp3OLIFlhjNBsRsB47jKgyZ81Z5cxFs4ORNTZ3YY6ZdHFoUC
	 SbYeKvpjH93ivq3qBG9mdryzXCZVrpchgUTcTvqW2Ghx2VEMYwR5PxazXWP/cKZZw
	 +SrquEtZRpZgcIrfa/sInYQeeYr4HFxju5CGVbcM1bch6GDtzeiQbQVtbScUX3sLZ
	 HguU90L3Vr+WDXexfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.241]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1uwGPl1Tyy-00DZqf; Thu, 16
 Oct 2025 17:07:41 +0200
Message-ID: <8b9e079f-c119-4dc9-a489-9cfc8e322c27@web.de>
Date: Thu, 16 Oct 2025 17:07:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i3c: fix refcount inconsistency in i3c_master_register
To: Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Boris Brezillon <bbrezillon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: imx@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Shuhao Fu <sfual@cse.ust.hk>
References: <20251016143814.2551256-1-Frank.Li@nxp.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251016143814.2551256-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BC4xs0imx959L5ImbTIPTPNJw0oZvReisz5nOYXi91Tc7NTBnLF
 xZewTBDkmn1eYixfmln7NqQFXl8J4Zd6BTbVra02wtU3+bLkFbs6HNZuTpq7jS+Qai6A0cu
 VsAI+bWNKj84JrUR37HNBE4Um4zJUggiThW8MoO9vV+T9VNNJBqI36psuyLjGvRhZ/PeJ/o
 oFifg/3U/OBl3MmJigBmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k3RCl8+0Zcs=;7dGoSMsQD3IMI5a6eamSi+7KqO4
 Ty15zFjjHG1k9tpnsuQlDRJ4eSlw+QYO9LNfmP0C7D4FN5xyyUq/QW8rb14USLEzlp+EQaJrS
 z7M/YMLkx+rPs0y6coP/gf86X/dgu3TVpwhtjx4HC04rchhhH5yJNOLpeZdQA0EJtwgoBsGT+
 oxyhMYIhjptZg0HcB4db3j0RrWNJ0RP1mp2Walh58sHR9xPaNSpXRBFroSGS1ZFZMyXyKCEd6
 7MdSOfU8oDS0noNtNDMIU33aMqxWrllNpMTHuOZgR8utaseBghLGIDNcgCTRcCCREbfbnM2Fk
 qtZaD/ihviAIrTLHGEZ4Mx90cF0NxMYCldUp4FBalaE9KmF6ncZdNQNzBK0Ou/MhffKu+KvDJ
 U3Sr0mov+uQaBBJPKKCESJ+jO9ZXVAXugXj5bFO5pyBKuhOD+Ms1XmeVDhHC57CQhMQN46jG8
 bkUwaQke5SRxwkIpnchFKu7wqzQkxHBQdCrjmobV1Dgvk5AuFVn2Ji40By0ANfJYxgYfh5GXn
 81aLVxFnY9UpbdpHTEFC5I5PQcWPjVQGQKUdCPQfdskUP5NHSKYv7Rjdyxk9UQXWhVttrUsb+
 jsGyVecexB1TTuxW/NJKQFQtFf1ZiZG4qGN2n6W8t3+I6U1G4ARI/k5b1o91qtq6KZuEdk+tI
 cXCDz9TGm+MY8S3JmBvX+jKq4gAHJO5xHXBgrEHoE3AbAqfgF3GHofKZOSif/ycnxR8QrMM68
 UoTzvXxaQ8VfXPyQ0yFK2RrFtrgmF9tx5FucN8z8qD8u7g1inFChMkhDFwDz9q6A6N6O4BCZg
 JI7wJpzR1eb5gfUH2tObkBYnZk9YfCqKfLnl3RYI2LIP/IS1byye5pBNETUMIzfaQ2L5drvT/
 bufqfyCTy4JBNDytRE018FdJhknGqjZGF0zwSuPb5h/fzQCn/pLDmoSQ2xoH2W0Ku8BbP7kLH
 jRHAZfGEKsAJPjdRzgDnV9LQdiMKVrJugrhF6Lp51U9gVWoVNxYawHL7fd3n4aukfrp4Mr5Yn
 S+jF7azhrEwKJsPHtxc6Sowb1zJm5sQ9rXnvxx5S6CCmVVZq1EEyUyFvYUrhnmwAaQLh32gk4
 DZaFiQASDxv5woRbUS90IwcHVgSVxLnT48pi5EfKeZvPGDJ6qLfEnWAXz+l5dakvlrBFZ3Tdj
 ObycqJzXypiMD+zl9t0PRAlNcn9WIJEi+v4R4j+cbAlj6C8oayluVoUX91vPcX659KRS5Zgiu
 DdIYvRWlqdEoSLJdHOk+v647MjhsHU07BUOUPUAaTyk7e22GFJeuXZklkkxz2W1Fsg8xMnXOI
 JV5eXeUzGdmRKdJRaDyPOA9t7vNR0Q7C2A+AVPTyG4jOXQZYYyqMEAUKi+4rL2KT+nDxBpizg
 L1b+AKSNptR6WBR6/YURTdRE9BFUULnTzuDvCP43i98CfuuqdAIfNUI9WF211DlbnW0drKNRn
 tEbj4+WLNP7uHd7Iea5CI88qTQAh117SRLjnG5dy4QsC2u5e1S4i0jLobH6WVv/TraBQNRufd
 VCH9K4BsUtZ6hqj19FwaEEPa4ygyuywCXuserp9XUOrqnPzEphbVJL81D9npc8yFG77QyR5YF
 7klLBaBlpVXdhO2GjQZvNYMpLMbdNSQrRyHlTM7HYzUaDLs2WrFNCJwPehd5MFl0CKalAXWdF
 OWw/wQ2FP1ehMjRobqPe/peLLmwC+RJ18gQ/cIvGHO/8LtsbFjItzzhZ9JysKZW3ujmeAn0U8
 rcf17inCZA3VoC6kpblG/ngvK0zmYqK1i/VpIIg1niHnnSDzZZqt35qsi1AAV22xmU0HDCc60
 93tKzRnLer45JjqDf78Sm0+3R99TMClyg2PUFoy7X96J3LnOpsGXMiJdpeS7JEHclIgYMSFmP
 LEciOSTBe7O28VuUEj9VID+CP3hKWeQt4oT8ZrZ4G7uCrsAmb+5kaqxHnrm6OEr0FM3JbQuKw
 nx4aiahz9QjpcSLyy3ewBF6rZfM/2a4PlWL3Ay6vl1SDAgiERSaK9j8sx15/wFgJx/tgsEziN
 cw7BXHAwmk07aDr4PmVQ/il8eGAPYNuhYPBuiCdY7Rb8tvCLNDSVGb0WRVTRBJ4w0tSaYlvtJ
 dGtk5p7ZMka4pVUGHds7XB6NCkI8PnWrcidpgspfTiXhq1P6jPOOMdP4NO630iuQK6yDAi7GL
 4ivMwwo4fwXVr8lERiBsB6dNbkd2T4CC+2H+PrNvrzDpmB1277rCBIx//2Zrost/St2WmUy4J
 NWedv6qOrALHrYz0faFf3NCHdO4lG+ba4CDjwazgbRl2yBo8HjFvRJv4KSJbb1LKPyiWnhqRn
 cstek1w5/k8dJJ8VY006L2dIpi9SuPGb532uEGcD9i45GOFnW1uqbun64Zl58HWC3OidJ27Ze
 O+oP9xAPbXjVBH7mytrTboDT+RV6j2mHXEKalQCUCYRkmIssMPJwNL2xAsuVkqAcF9HvBdwNh
 2k2/MRfZ+QZNKd73wi8p3pSwVK6lpkViy7wLtpqy3sVm4l5g7KiNWbw8/r4m7Ex8kjveNBop+
 tGJkFwXYauz84Rx8p20UOZAzo/7UzJlmYnvd6F9xmZeQElxNRT9u++/7wtuv04K/El13Vr9yn
 ofCpYTV4e6e9EFkuSZMfyp8kn4gT2i3pfUzQBeJ0bOSOK1CrG03tA2H7oH1XmCzge/KONmp4J
 TRYBvICkt87RvUYg2YVrZzwDOtucdbi5fu6rq7siliEN+hpY0ILD6ZuZNu7CBYIALQH1upvHr
 IQ3aJcNBnJGDss5S9o6qwlOgqAXiupM3DlWQYUu++vTkXSVe+CrkSYt00kfiODOxTCiS8hmgu
 r4ohz2rXLOHIdqaNHEZG9GWj5U6nkHjfjKuKbVZmfbfPZKlGXwjdy6hPoqeEX0zmO6sDjTy9y
 xjNv/nvUBv8+dkjDIZ5PI0DdlblCR7QJqoffViJ/+vviv3RX5q3w4BDfroEGdgXaEaMbFh2I6
 eQQNaTxn9vssPhB3VctK5kca3/Tj70ktKN5NWAStc656F/9FfMjfNF0q6OTL5fHfENfsO/6pL
 2o8y7ie7TspCmrVQ6SbX68a3Gfs4IYlKETXb814Kx+LTSjjBjWV+s9mGy1ROzZcyM0fXoIYu2
 a+jMc3x2rwb0nixeKIRMVkKxOvQoOM4zW4IF4CJPICNvq5csY5H8qNJwe6UnaHR3CgqzTAejo
 7e++tCofkCKMTriUiA+viquakWVqi3TS/NT5YMOqrRfdI2PYUiHx6wvBysVC93iY7Y6rzJWw7
 pQYPbCC6HYreFQ7mnRM5IaKSEdewsgGbGLuLnbJXue8+t4gULu9BUTYz7U/pUF+UjzmaiXFk8
 Isb9PlujkWRcUrfkvflJNirdD+m/vzsmSZhIwzSp6viW+g2Ioo/tBQZErPWItFzOx9pSGaa7x
 njdqu9N1OXdH8EOseDzsyyVRCpAJKrao+5+KdEJK87jSJ3gx8LINz3avJc1w8YKgaZgWOCrj4
 t8BDSPLb5H2+8+nkdKjZuzG1Pat5IaHoqISEtxmTovnzEdjtrdkDsCMxLpJ/Yrh/njBhEwg4N
 4rm7AHY6x+Aupk/UFQ7U5Z9IXx6pE/AxLiiShImXZ493h5Ijz9DsMCdRxI6FceDMwrqA6qOQr
 IvSMhgGnXfgcO3QTt0dVbyM5KDXOBV2u7wYlWqM6tRbsseFpFAYP+RFe46PbGtV/6dmwkDdbf
 bBSL3/pqt2E1Vsbp6KZCvl2pq28NrrtIKDqhXhw41QlP+JXYDKXWZS6o+7Ln68fogYw1JtS3y
 7LZCH5Ol8ru3lqoJQcYepQ203MdN1XASp6sydWA9A51EXhs+P4cZuajqa/cZzDEhG894yVFeN
 kbuecMApSAAM4tvL42+s+N+A0F4rxi9eizdSgMKHb2IovKFcSUIM096F1iXV+ZCUtWdazb0D9
 xjTItV2xGohSS0cuOaX38YQEogV/sn/KyJReOCIuGQKgtOxzz/6QeF81EqAxtcGxAACo5akJF
 qOLYG+o/aGlNJkQRT196IM8+EFzINjsUr/Vd3w+0D3X/U5A6UKEpswAKKRURQIMeQRDxuDuKI
 H+PE09LGxHC5l4qsPX/6xyK/NGiwXoN5Enh8xR6sNZ/MI4mYK/YaxM7uYii07RvAi8yuYcEUB
 rITO0ZJEqztrDjHNxm5P8Av2gXtgtiPB0J7SaXJUX0v+EZCKHA1t2eiHbdxY1Nva/h3/eRe54
 01rbCbgO5BP4VESVrXaLanSe7v7H8xgJoC9kcI8C97ZBZcp2yOpawCp+6UbjEKxNhdt4gvq0Z
 v4an1brbiIAgB3ljU60WAe74+NBDYPqWqYtnThXQnskvHDsBp6qm39/WRW2d5UOCuDCdrpHc5
 jzkfP72q9gMHpt+I/pD9CRqfuJdLE+OPnH9O5kK7lLKwUNqbRvSxA+HYitMzleY5TBCoMycgH
 RJS9akkmS0u+TgZp3tlz9wbhWqrEefRbX1N1VXy4cH7y4f7qZnwuoAZOHnT3WDKMg2RMpmcgX
 ofWc0q05E1TkKecmsOZzxKhtrfTfCjRdCeLvuCPYywaGSQvGlF+O8WBbI4bzh1jW4NV4Ykjp3
 RgsSqdleE8MsmLleUz5CoFn/9TPxddHyYzrqmuE/FWtUXpATL4SvM1QhplHddiXdlvX5crY4F
 f9dorcciaROvX1dCWzPKVW5VzrhF9PL13TE0ypuLttdDU3nSB5c52yvNkRbslMV80hs04lU2y
 MyBEM0tNE7T2FylsNbwbbYtdKbuH1nlD32/Z+JTFnjagGdB3Lda3W/sww6c7FPXCZR5mR7S+m
 sdyChkD5aEqPSL4ClXDDy60II7TmJnSCFP5K8yzsK8Md+phYkLEOt8jkk7jVscRaEwcKmWAE+
 U1Ezds/GF3t74gQKYFu0PI9Nr4HrO3ok6A9tEEV4AYDm6KPhrc7fR89eqfmzIu5cQEbQDF76L
 bppjnQvj+f1HovJRPSGtz6j+i6eyDrSnKa24wRgB/n+qrN7WlXUj0F2bnM4c/uqCEftkQBqLc
 ISMjx2esywKV1OjRP/Mq1ukN1zqTw1F8pAdn0c4DyXuyEQcCeBDoWU7/nBv95VuOw0u8+5ogr
 0gy2g==

> In `i3c_master_register`, a possible refcount inconsistency has been
> identified, causing possible resource leak.
=E2=80=A6

* Can it be preferred to refer to the term =E2=80=9Creference count=E2=80=
=9D?

* Would it be helpful to append parentheses to function names at more plac=
es?


Regards,
Markus

