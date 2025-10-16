Return-Path: <linux-kernel+bounces-856696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A85BE4D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 470F04EF6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9214D30170E;
	Thu, 16 Oct 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0uoxcHS"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A23334694
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635406; cv=none; b=ZQ4hOcXZ+cIIzIey8w/61MQ0D6i/yuMn9ldmawFLDa3iIqEAQxWYBnGLe4jqy0rfClQ324Gf9QVi9zZKdigC4p+tprN0LazGSzvWUYgfPqj2cUrju2Q6F5wagJoJ5ob7BbKi7m4KZxeTv768jWNz24vuaXMrieoFnF91kzBzHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635406; c=relaxed/simple;
	bh=hqCkyIa8Ndsof8l2/5nc/dxBgDQ/Lwmq2f9+SsjQxG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMRwm97gCNpnCP208fOpBl+4/H3fpMGp6HszbjgPUX7e/FspzgLdIYCXtu5XBj5lt4wOHKvKQ1IOEZMsjH6ZfrGTRrnfVmU07uIgfdPGZwwWuMg1J3hzFEHujVkCIrz1MvcE6OBVODbpLNd5q8qneDlvaBvzbNQ6ZfnlqKGnM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0uoxcHS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33ba38ed94eso1167868a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760635404; x=1761240204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pEzS7xov2bHNWnYhM2kGJUlTre7AVr9zGXjCQj5iIk=;
        b=Y0uoxcHSv5eXE7nApcz58Qvq6l4xVKShjQRz54CGoEKeIiN573tnE2fOx0YYrO3Lda
         mPfxcTA7gJBiCIePO+nZCpIsq1pHf1MiyJApeDMKgqZUCk6chC/Ph2JibTCtav/6lua/
         CMopJ7mcr4sQiSeBJAx+h2RPMkqa5g5qhepiA+mOP5Ee2xXh4jU6B7mwLQHDHzlFAARh
         UJlgmmrIwC4fJ1xfwNAm1+f8M5+yWxsgAFsYDg/sS9dozqapYxS8yayhao+5IrM/BZeB
         H3OSoQa/jzsTQDVwKpUMaYvM1M2tshqIJP9T4iZE0l/WoMT0oYyDcuadF8MVwK3NCcbg
         78ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635404; x=1761240204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pEzS7xov2bHNWnYhM2kGJUlTre7AVr9zGXjCQj5iIk=;
        b=DfTTS0EU1+iFC7b+4dqgD65ANeedvn2w3vqIPap0UBpTdUXyQcxmcC+twQ2BEI6iAy
         K+djUYqUWBb2pxpMLrtMB5qxw2S0boCPMmju5nmNEe7iD0tR6SYdxjdBIz359AMeJweO
         boJZtjpcSQ735FVOe2/oHrOeM50rHYy5GPQkqJP0cqoCQ1mmohp7B/V3FML/ikD82MpV
         mnacPOvCoTG0HuPtDptiVNoW7cpkqxQO1JNnDpV523qJNhHxvoyQaJkWzUfZWipjgCNo
         nQeHCd/Qc+q+7Kn8JoiBEY9ksM6Aywrmlrm0WbMuxEgDhQDViFaEWiP31jTXjufHAaId
         5uXA==
X-Forwarded-Encrypted: i=1; AJvYcCUSGuW57RVhw7O2owA1WyIpd53gl3lRC/uQEbMnC7jQer3ul/4qeGx+Y37rCavlYvFaQ481nfLB2+3bJtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjEQhCM8CQoQjbkxdhlYtxaSYjNcDBt6eU6O3TX8R3zKRQ27t
	13zI7q9usP7RhkbfoP0Z80MNxQSkJb4VcJqmoEwB1QpkWAL3rWtgnvFh
X-Gm-Gg: ASbGncvq+MKZKNBzJ5pGxqlfCT4rklNAlJVzUD1ja3rmL1e9rIMz/TZZkQL7kAN0wrw
	dIvqjtvs2gshdMr6crc0B814KVlxJyK7Om7VIVto9gLksTPUCbxqvZiagZxn688VU5zNVuSTfiM
	OXsb2heQJAhYzfydr0iAYmsp7aihevDEhBgRV4jsOJVSxFcF0q2Pz/V00BItzke79EKuKD92vHD
	ddhQVAun/Xrwfmhra/f1VlMWqBU+57cOLmriZo6311hmRzfFqF0yD7CIXEkGd33tOMW4PGwoRZa
	TxxZz0UWi61GccE/gZo4Y4v3HLRDUcB8KnotniBthAs3wwyHQw07h5x71N8Orq1bV7XWdei7ZlP
	Dz7oYUEvJnYKazvUVutIW57zhoKNcwaK1FEuxyGSmyOM0nimbmsnnEobpHvOAYDS8sDV+5/tGwZ
	MFA4+EkDusvq+Nq1muybV0vGJUkAV/
X-Google-Smtp-Source: AGHT+IHShMrQ5kJEQ9OH1QFWe+vtUUyhQBVUXDSi3QgLq8tBOpNymms3o5Fo6o9wjoKZQ+vlza5VZw==
X-Received: by 2002:a17:90b:4d12:b0:33b:cfaa:d01a with SMTP id 98e67ed59e1d1-33bcfaad01dmr461500a91.25.1760635404088;
        Thu, 16 Oct 2025 10:23:24 -0700 (PDT)
Received: from cacher.localnet ([111.94.119.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb663285dsm2588728a91.17.2025.10.16.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:23:23 -0700 (PDT)
From: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
To: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com,
 Armin Wolf <W_Armin@gmx.de>
Cc: kuurtb@gmail.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] platform/x86: acer-wmi: Add fan control support
Date: Fri, 17 Oct 2025 00:23:19 +0700
Message-ID: <5048620.31r3eYUQgx@cacher>
In-Reply-To: <20251015192551.321200-1-W_Armin@gmx.de>
References: <20251015192551.321200-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, October 16, 2025 2:25=E2=80=AFAM Armin Wolf wrote:
> This patch series aims to add fan control support to the acer-wmi
> driver. The patches are compile-tested only and need to be tested
> on real hardware to verify that they actually work.
>=20
> I CCed three users who requested support for this feature. I would be
> very happy if one of you could test those patches and report back.
>=20
> Changes since v2:
> - get rid of nested bit masks
>=20
> Changes since v1:
> - remove unnecessary blank line
>=20
> Changes since RFC v2:
> - improve error handling when setting fan behavior
> - Add Reviewed-by tags
> - whitelist PHN16-72
>=20
> Changes since RFC v1:
> - remove duplicate include and replace hwmon_pwm_mode with
>   hwmon_pwm_enable in second patch
>=20
> Armin Wolf (4):
>   platform/x86: acer-wmi: Fix setting of fan behavior
>   platform/x86: acer-wmi: Add fan control support
>   platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>   platform/x86: acer-wmi: Add support for PHN16-72
>=20
>  drivers/platform/x86/acer-wmi.c | 292 +++++++++++++++++++++++++++++---
>  1 file changed, 269 insertions(+), 23 deletions(-)
Hello,

I've tested the patch on my PHN16-72, this time the fan control for CPU fan=
=20
works just fine, but GPU fan control doesn't work anymore. no logs observed=
 on=20
dmesg while changing the speed of either fan.

Thanks,
=46a-Iz Faadhillah Ibrahim=20




