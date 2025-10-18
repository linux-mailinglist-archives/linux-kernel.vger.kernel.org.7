Return-Path: <linux-kernel+bounces-859221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9A3BED0AC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 739B64E272D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070D28314B;
	Sat, 18 Oct 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo6bFSao"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4C1B4F1F
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760795462; cv=none; b=oBo3HQUcozpD5URFh4+lpPNE2g+DMl0NYLgk8Tc5GVsk27Vc8aoUkgdUKzBDG8omUb6dN1ZHlMBSPGF3u4+Hiv2wXnTrWAvqob8HkXAz9Nlru+biPyTxleUzjFr3f5hmFt6Okp+0W72TiqWwNppzuk5xvuvyZCat5zi2jdVFFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760795462; c=relaxed/simple;
	bh=H4XC02jwzmIvWBlWZFVlD8AYAXuXdd+oXv6dBP/Y7Fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHiGGubhIeFFGPTtrMjxIwrmcx2FRNpCN40mU/42LVY8cOdFp/faMYLmO+69QJBAx1H5a74cRW5vMjCnR96cpvUFvECk1ib47zbNcbhXWO1h+0YDWG0hFizSRk0SexkLtwgpyOGrUxCWG3yAGfyaznW/aj02HVJcKuNDkhufNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo6bFSao; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471b80b994bso5571185e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760795459; x=1761400259; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4XC02jwzmIvWBlWZFVlD8AYAXuXdd+oXv6dBP/Y7Fw=;
        b=bo6bFSao2RTB9jQUGiyXPqoFscyKTxAcLlVhnBMJM8KuwtqZF8V6Z0JbA6q/6lihyi
         lDlL0rlhtD+RLnGZIVHkLEFOovExMTq6KWYiJfcrLNH95g3+4S+YfTixdEmTpHuOnc/Y
         dVzJcwIv9tvb0VMA6LSA1gfSgbAJHv0rpm0DeE6TmYAjNffO/f32H9Q2lrc41ItlXN4Z
         sd3vvnRq2fVXZS4S06dsQWa5MLY9LBANpZns6iH7EvApYkNJ2bQmY8RUcIDyt0UEKQbA
         FIncqfUGmVoQ7dBGV2fankh1DLt9ppGlLsnI6ZmJl0tGkTFSS+WcnVjJwiY8SA7OqXdS
         Aoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760795459; x=1761400259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4XC02jwzmIvWBlWZFVlD8AYAXuXdd+oXv6dBP/Y7Fw=;
        b=R3sGHi5u5PYRje/FxL8SqaP05FJESeSs2p7dMxO+r6jlcV66Zr8WZduWmYh3K7qSu+
         sDvKSKrfiGd7drsR5UhggdN0VTvlLcmNIq2sDLKi2l9JNFoe7+PI99Kq/w+bH/r1E6fy
         EIBf1o7hsB1RJMNphwidgvKvTRcxwhSC2cmMnu7Fi+3v9XGln3IfORzkONuK5EEHxtT8
         lA+TwGuUpLFmP/hRN8S5/XzSzQzFsFaBFmJW3OP8Vl97OGSvafXXcRg2lHaKH6UXunBv
         WMy+kdWQusvlC7ZBEqUFH+h7Iy4XtqI6Nvoxd2d0vodevarZLj540qaR1kVgamyX0VW+
         WHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVLRdEp/HORiT9tw32FQSjm1hUGX9Ku36Ci6rqRwZ0hfeZTZt9MnDSRBA5XG6zFWRLoWKCdXxnY3dkJaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQC5sqVYeFSrKxWbHrztgks1RlUwhIEWrVAyBlQ81VqnSQ28JV
	Lxo48XhEQcOWgkygRzdrfBp4uG7gEr6VcjsxXo6O+1yC+nRsoByUliRT
X-Gm-Gg: ASbGnctC2JxcbSKcDyzvJvJTDMWy4/4U5aCHaQtEPFgR5DIQpGtr4d5G7WDdyOPn/4d
	bTrQwmnz4ZCxhHDKL6fkiPRRuoKiO05S+IHkQfUtsXYXw+yxbFKkUgqqhEvS7JQtRnKcFUJr5c5
	tb3iwobjlS0a4zY9GddDVpUSuSjhCvOw57RrSXXqgdC1lyc6sQ2/Y+K6mtrucpo86SRrWhaWm5n
	GBR9sodb3qf7GElkC5dHjBp0wvalEmnfhUrY5/1MVTukqrMFZEot0m4rEhaNSI6km5RKgXQ2WgF
	TZp6yzQCkLCf/SdfDKeJpuXatP5vt7DuowhFAqM4fRsey2Hpj8JyHf3KenX8SthbbRSRkfcVvCn
	DP97QtlFJxDUYcRpcyLvAsoZz1VlpKOdzOQd53WP7s9lW0a+5XYZkJCq4flPAOA7VOnEGRo+/Jg
	djgihy1BRw5v1xCJjaOABUXAvvhcJYIC0hv790SD8HTN8Zj5HZoECrZqY=
X-Google-Smtp-Source: AGHT+IGCXXxrQgd1EYgtv5VJuy0v1uJ9qqFR/wWr3wDngmDs1z9Yq8rUTLutJ5vzlAyNORMZR7xTyQ==
X-Received: by 2002:a05:600c:4715:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-4711791c8c3mr54887815e9.31.1760795458332;
        Sat, 18 Oct 2025 06:50:58 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:a776:5e51:5cb5:418? ([2a02:168:6806:0:a776:5e51:5cb5:418])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d382d8sm48677685e9.12.2025.10.18.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 06:50:57 -0700 (PDT)
Message-ID: <10919281648e306fd3f6713437b4793c50bb6692.camel@gmail.com>
Subject: Re: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Jeff Johnson
	 <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>, Baochen Qiang
	 <quic_bqiang@quicinc.com>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, 
	regressions@lists.linux.dev
Date: Sat, 18 Oct 2025 15:50:57 +0200
In-Reply-To: <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
References: 
	<20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
	 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
	 <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
	 <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 08:57 -0700, Jeff Johnson wrote:
> On 10/17/2025 8:37 AM, Klaus Kudielka wrote:
> > Unfortunately, this particular commit completely breaks the ath10k driv=
er in my setup.
> >=20
> >=20
> > Hardware:
> > - Turris Omnia (arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)
> > - Wifi card (output from lspci): Network controller: Qualcomm Atheros Q=
CA986x/988x 802.11ac Wireless Network Adapter
>=20
> This issue was previously reported with that particular chipset.
> This is currently being tracked at:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220671
>=20
> It may be useful to supply your information as a separate record to that =
bug.
>=20
> /jeff

Some more observations on that topic with the hardware shown above.

ath10k_core_start() calls ath10k_wmi_wait_for_service_ready(), and later at=
h10k_wmi_wait_for_unified_ready().

The now *unconditional* call to ath10k_hif_send_complete_check() inside ath=
10k_wmi_wait_for_service_ready()
makes the later call to ath10k_wmi_wait_for_unified_ready() fail.

If I call and handle wait_for_completion_timeout()=C2=A0first (as it was be=
fore the patch),
ath10k_hif_send_complete_check() is *not* called, and both ath10k_wmi_wait_=
for_service_ready() and
ath10k_wmi_wait_for_unified_ready() succeed. Everything is back to normal.

Side note:
ath10k_wmi_wait_for_service_ready() succeeds in both cases with time_left =
=3D=3D WMI_SERVICE_READY_TIMEOUT_HZ.


#regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=3D220671

