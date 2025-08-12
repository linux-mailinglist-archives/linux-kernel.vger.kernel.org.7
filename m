Return-Path: <linux-kernel+bounces-765329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CAB22EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C70188C4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94F2F83D8;
	Tue, 12 Aug 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cUAA08ZK"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2375242D74
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018884; cv=none; b=CDhlJfx+7tObOIGrcSSIZiwL+ZlB2ryLzgSQAHg5h+LKmxUB2lUeXxD26ntq8XbGq5HW7m7dstE4qFnS3/RS/cX+omToINR2Nyfnpobmp/QvlWESx3ETyxAAR7GjmeryEf+lnZ2oWhrCKO6203DzAk/YhIqnDEb5bl3zfFS09l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018884; c=relaxed/simple;
	bh=PcjRSmowg+xnVo7SxRi4cwc0+Ee7unBuT7FL46px6hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OuSecXuq+z7A9u2wbeyF5Liw9k50JidLyoXMAF07sVDu6eaXJkwReNtVPkODp6cbmWDVJ/RhhWuQmaSI9v7BVN6zhUeDpKQYDKKtROo89LvHlIX2rIC8NFP3EX+2QtYb469mDGDl12NZcIkeCQHBRlAg5xmCvhaVV9cvfLBbmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cUAA08ZK; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso37132955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755018880; x=1755623680; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PcjRSmowg+xnVo7SxRi4cwc0+Ee7unBuT7FL46px6hc=;
        b=cUAA08ZK8NiyNlUVgND/Gj9QM6Uea44p/e67Z7wfiNI0y1BVgjy4FG2bTrFDedoKPe
         hhvQhlHZEA1QIMb0wL7dSeIw2AQkCjQkws03HsplIjzUwZtNx+JWktoFJqpTsrU2gb24
         N2fjN/N/GQ5C/NR/J3GiDLKqa0Mnsr/KewDAbIC2M/cvvA2D0ZwJn6G8jBCuZ/Qg74BN
         gGJ7+QIz0k0HtMd3Jxkc2EDFln36xoQCzby4hdX6Lwe2U7ZE8WNlwLnJDOUHLVIUTCVo
         ga4y7e2vKRTakhsi0vmS+2RLT8fmxRMMp8zp8V5GuD/JzQ1RNKtaSZDKHdsUceg8efu6
         9HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018880; x=1755623680;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcjRSmowg+xnVo7SxRi4cwc0+Ee7unBuT7FL46px6hc=;
        b=LacD/bljA+7cDWaBgJASzcYV9zp+Jdrgi57OlEGKALdsGZj8Lh9esmny5JVptLUiIw
         zTx43V84gHe4/MLdNsqfKDVMcbgt/ST8Q7yJ1ueDoob1faOB/uxb6VMuyJPSB5m0Wqio
         MLQBErl5roqXnCXCtL6NySvrFZcN8eNorX2sfyubK+pFJ0qMQBCPR0nhO16lPf0Qah/a
         2d30ZEHTNakVeuoApuB4McacDT9HFZ9oHQUqZDMNyibBwZd+rS3odyLxBh3egVoAetvB
         8TuBNlyNn3RRa5eNdUJau3w0kLMGgqhuJTZJJD/bihOc129kfWTPuOE4Bh0vrtmD72P0
         hdrw==
X-Gm-Message-State: AOJu0YxqUmfgpCxI+tnEpZupUsul0Bujb+QsLiJ/btjN+mQBqrDWze/7
	+HQ75JPkaZLwvoz/Hr1PnoQ+koFyq6ukSVy3/dPITXz5Bh7qZkW8jWrR+ovrB49hQgk=
X-Gm-Gg: ASbGncuJSdW0eHwFvpBAu+KzX9lLfAAhqLMDib4KcQmuDz1EJhDu8JB6XcbKmmPUZZh
	qVAogjYOCkcM5eJki4cqhpcHLfnAiRi5p0Mbsmk+FrmhkPhLoPFir8vEAKeXpznGzCUNyHQ8IY6
	tT0bH/7CTnR/Y2DDITr9MbZJonxY8K+0Xx+oTIBYgcwEF/3IZABRQNroevkLJk1AjdTm9u1xYE9
	BnA8AaeMTuOMdoYuCfuQyJZoH11R1XPVozjhMxB/8ddAtoqr5BU8sskVygkRSMXWupOnl4jBiCD
	xEfqjjC4MRvK5nX200tmX8tWI4YPNk14g132gInxtzFchCcwKuevkpVytqA5exfQK0uCghurPRf
	GxBVC1EsJZNDgYtQypjK9K75S21CkUZBGp+nZ3iyCxv/pSn2wcgsl
X-Google-Smtp-Source: AGHT+IE+/j+rEEIZd/63by1IWW0prgq8WeeqliYFo8/XwBxphioSWmbGq68Ck2+0UXtemH0kUDsMwg==
X-Received: by 2002:a05:6000:2383:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3b91724f246mr176279f8f.17.1755018879936;
        Tue, 12 Aug 2025 10:14:39 -0700 (PDT)
Received: from [192.168.3.33] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0e78sm29735001b3a.99.2025.08.12.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:14:39 -0700 (PDT)
Message-ID: <3444595a705960b1f38a34368c22d637a92ffa4d.camel@suse.com>
Subject: Re: [PATCH v2 0/3] Handle NBCON consoles on KDB
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek	
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson
 <danielt@kernel.org>, Douglas Anderson	 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Date: Tue, 12 Aug 2025 14:14:28 -0300
In-Reply-To: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 10:32 -0300, Marcos Paulo de Souza wrote:
> After the proposed patches [1], it was suggested to start using
> console_is_usable instead of checking if a console is enabled. It was
> noticed that KDB was always calling con->write method, but this
> callback is not set for NBCON consoles.
>=20
> To fix this usecase, export console_is_usable and add new nbcon code
> to
> acquire a context that KDB needs in order to call ->write_atomic.
> After
> these patches are accepted I'm planning to go back to [1] again to
> use
> the function expected here.
>=20
> I did the tests using qemu and reapplying commit f79b163c4231
> ('Revert "serial: 8250: Switch to nbcon console"') created originally
> by
> John, just to exercise the common 8250 serial from qemu. The commit
> can
> be checked on [2]. I had to solve some conflicts since the code has
> been
> reworked after the commit was reverted.
>=20
> Without these patches, NBCON consoles won't receive the kgdb
> messages. I
> tested using [2], and it works after this patchset.
>=20
> Thanks to all reviewers of the patches posted on [1]! I hope this is
> the
> first step into implementing all the changes suggested in that
> patchset.
>=20
> [1]:
> https://lore.kernel.org/lkml/20250606-printk-cleanup-part2-v1-0-f427c743d=
da0@suse.com/
> [2]:
> https://github.com/marcosps/linux/commit/bea249773c9caf56821f9ec06c7f9649=
e4966c61
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1:
> https://lore.kernel.org/r/20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.co=
m

This patchset wasn't thought as a v2 of [1], but somehow I messed up
with my b4 setup, and it's like this... ignore the v2 mark :)

>=20
> ---
> Marcos Paulo de Souza (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: nbcon: Export console_is_usable
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: nbcon: Introduce KDB helpers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kdb: Adapt kdb_msg_write to work with NBCO=
N consoles
>=20
> =C2=A0include/linux/console.h=C2=A0=C2=A0 | 50
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0kernel/debug/kdb/kdb_io.c | 26 ++++++++++++++++++++----
> =C2=A0kernel/printk/internal.h=C2=A0 | 41 -------------------------------=
------
> -
> =C2=A0kernel/printk/nbcon.c=C2=A0=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++=
++++++++
> =C2=A04 files changed, 98 insertions(+), 45 deletions(-)
> ---
> base-commit: bea249773c9caf56821f9ec06c7f9649e4966c61
> change-id: 20250713-nbcon-kgdboc-efcfc37fde46
>=20
> Best regards,

