Return-Path: <linux-kernel+bounces-858002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D5BE8859
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF041A64987
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED42E6100;
	Fri, 17 Oct 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XDNqFW0B"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902B332ECB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703140; cv=none; b=q+BglSoZPFtxHN+OAMVogQZEhOsIQUTAS7ktImNTN7rHodIEoR6/GQwKkIPtS5msuixkrucjMkUJLKkcYz4B7G+kotnljM/UHIf/+igJpo78WpPZVNBHnBxjDgF8KlJmzQMwqFJ9K1XkPrdjvWI2Ra4P58Tcbwav9L6KPd7o3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703140; c=relaxed/simple;
	bh=RLaam3eDzxKnxqdVWx7xx5w2HRUiHYGMu2eLhGOl2Zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRQt2+sGDlv7+m/Td/iRd/r8oLzIcF04T5MbZjyWG/yGqc7sZNTs2EufOh2Lm+NGgpc8GQZnG7nIhcmB2tXiDfd0mElVoeSTxIufUOmN9WQiPMLYmFx+CcUUp2dCIag+jnEHx05JV3/m0zAtZ+8s5cf8sFKI2QhOATRIOXpGxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XDNqFW0B; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1615368f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760703136; x=1761307936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8t5uU17y5FWZJi8y2KlCirL2O1f/+bghI1ZgAQ2aUl0=;
        b=XDNqFW0BMNg28KnG3s5Cm48onw5UOygjWfOo7LehLz96oESCX2mfIN7FyJpzPWrAg4
         fLAoBH+svJYYNi+TOrPWKcAWcjRZt9W331qWQ/wx5R/B41z9RtT17VaJUwSH3Mw/5v95
         EijdUvS9K8TKSEIYphuPa+HMRh/DACegi3j2Am69fThEas1FSLJAXP/JLfIinwaugRrB
         VA24Czt7DPI3qukGwuAogXhbs1CNtJIED9UNFJiey5FuMBIdIBn0+VvJyKpigfBdUj2I
         oX9vyu3Gr/5CFcwZsTvf8+J0t9lQiEwggGDW0pRFVK9bJczhrO3lQdIUB+xz0ye84pdG
         HAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760703136; x=1761307936;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8t5uU17y5FWZJi8y2KlCirL2O1f/+bghI1ZgAQ2aUl0=;
        b=F0RrATOCPGtzoMXYNb/omBCb7yVh7NmlsnT58I0X4DhaZ45eHToLy2IOW1bWNcK9dW
         R0s3SXv7Uu2rY9gnXMEDSMYoXVpaNBjo8ug1JrVd7FrhZ3J4nuUNUjiRNNrII2zXBomS
         IvDuzaIAJuuhMzo4lB5UXXgghX1mN/nA25a73WbFy+oQ3MGO5nGzYeHiFew3kL72aMmC
         jsLXPLsq7WKDa3Qc5GGi7nTPLyijbJK1h8EvzD036pDYszlgEf6rmDImg0iC1DpOdnoF
         rXBXsQC6oLYBy1StRPon9g4a6nGIMRPJci5mDsfs6VJbfUfqlv2u8CFThZTwRPfDLbfr
         vqFA==
X-Forwarded-Encrypted: i=1; AJvYcCUTQZ9enj0vs6WKfH4up5evFhrs0Gzr6YhQbXP1ra5g6xpLX/y8fTbyZG0N4GHFeZ3SZgJNjuNZG9RiCfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1N4e6F9nlyMq3bwNexdNVbYNJD1hifB6Y3tvl+2Qte96yGvyP
	uWUiSKufYr06MNOBzV519w0sJVAoHp10pqw4kI1RwzYbC80Qf9Bzaic73Of64Th/v8A=
X-Gm-Gg: ASbGnct2J/NAxuf+KuOG6JPt04EHiZejBBeHVpzC8/BsP7ZEpIPYBRIb8Up0Y5gbKj6
	BuvNd99jo3WcLJpRflrDVchU9v31KmHGD6Hj6zznejfHxF8eNF6Wd+vDpZ0ZSgiswtCcftM5sxf
	NaqT3/aiICKofYQBqsKq8fvZZqyY1PoNT4j3YZekqGOnljP/zGYuAwmwvhFY+rPMMYNf//L/n80
	igVqIGfZBwzMWh1YCZo0sMClK55x0jOSkdyEMSkI6U4g8QeVwFU/0xalFlYcBc+LiUyLFKf5AQy
	NQmFTzsKgg0K1PVU4KJPhn05N19Yrech08ktXg3WlAZ9302lhQUTTuvk2fy/sAG2OX9v+Yx9A47
	AcX8IUw26eJXIYkcdezc5SoUHOe/2WPxB/5MVs/kknuADvjgtvjR94dS/HpF71/oo4MYRMG2lFE
	70wjnH+GPc8kByPZyizuCmBxn5oUvPOWmoB5e1HkOsXnemxruz
X-Google-Smtp-Source: AGHT+IFHkO5Sgc8WLaSbVPgjd7sCri9UFPslwHKFyORt+VQ3pAN+PdgqQGsnCQx8LZORgV6J1Pp4DA==
X-Received: by 2002:a05:6000:2284:b0:3ee:155e:f61f with SMTP id ffacd0b85a97d-42704d14489mr2191371f8f.8.1760703136316;
        Fri, 17 Oct 2025 05:12:16 -0700 (PDT)
Received: from ?IPv6:2804:5078:81f:9200:58f2:fc97:371f:2? ([2804:5078:81f:9200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6522fc6sm5329709a91.2.2025.10.17.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:12:15 -0700 (PDT)
Message-ID: <c7f0902c324dc85fe42313300efd42a73dc68632.camel@suse.com>
Subject: Re: [PATCH v6 0/5] Handle NBCON consoles on KDB
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson	 <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, 	linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Date: Fri, 17 Oct 2025 09:12:11 -0300
In-Reply-To: <aPIpq17rUbNbLEWT@pathway.suse.cz>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
	 <aPIpq17rUbNbLEWT@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 13:34 +0200, Petr Mladek wrote:
> On Thu 2025-10-16 11:47:53, Marcos Paulo de Souza wrote:
> > In v6 the patches were rebased on top of v6.18-rc1, added Reviewed-
> > by tags from
> > John and did some small changes suggested by him as well.
> >=20
> > As usual, how I tested the changes:
> >=20
> > Testing
> > -------
> >=20
> > I did the tests using qemu and reapplying commit f79b163c4231
> > ('Revert "serial: 8250: Switch to nbcon console"') created
> > originally by
> > John, just to exercise the common 8250 serial from qemu. The commit
> > can
> > be checked on [1]. I had to solve some conflicts since the code has
> > been
> > reworked after the commit was reverted.
> >=20
> > Then I would create three different serial entries on qemu:
> > -serial mon:stdio -serial pty -serial pty
> >=20
> > And for the kernel command line I added:
> > earlyprintk=3Dserial,ttyS2 console=3DttyS2 console=3DttyS1 console=3Dtt=
yS1
> > kgdboc=3DttyS1,115200
> >=20
> > Without the last patch on this patchset, when KDB is triggered, the
> > mirroring
> > only worked on the earlyprintk console, since it's using the legacy
> > console.
> >=20
> > With the last patch applied, KDB mirroring works on legacy and
> > nbcon
> > console. For debugging I added some messages to be printed by KDB,
> > showing
> > also the console->name and console->index, and I was able to see
> > both
> > ->write and ->write_atomic being called, and it all working
> > together.
> >=20
> > [1]:
> > https://github.com/marcosps/linux/commit/618bd49f8533db85d9c322f9ad1cb0=
da22aca9ee
> > [2]:
> > https://lore.kernel.org/lkml/20250825022947.1596226-1-wangjinchao600@gm=
ail.com/
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > Changes in v6:
> > - Rebased on top opf v6.18-rc1
> > - Changed some includes, as suggedted by John
> > - Reworked comments as suggested by John
> >=20
> > Changes in v5:
> > - Added review tags from Petr
> > - Changes the way we detect if a CPU is running KDB.
> > - Link to v4:
> > https://lore.kernel.org/r/20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.=
com
> >=20
> > Changes in v4:
> > - Added ifdefs to only check for KGDB if KGDB was enabled,
> > suggested by John Ogness
> > - Updated comments about KDB on acquire_direct, suggested by Petr
> > and John
> > - Added a new patch to export nbcon_write_context_set_buf,
> > suggested by Petr and John
> > - Link to v3:
> > https://lore.kernel.org/r/20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.=
com
> >=20
> > Changes in v3:
> > - Only call nbcon_context_release if nbcon_context_exit_unsafe
> > returns true (John Ogness)
> > - Dropped the prototype of console_is_usable from
> > kernel/printk/internal. (Petr Mladek)
> > - Add comments to the new functions introduced (Petr Mladek)
> > - Flush KDB console on nbcon_kdb_release (Petr Mladek)
> > - Add an exception for KDB on nbcon_context_try_acquire_direct
> > (John Ogness and Petr Mladek)
> > - Link to v2:
> > https://lore.kernel.org/r/20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.=
com
> >=20
> > Changes in v2:
> > - Set by mistake ..
> > - Link to v1:
> > https://lore.kernel.org/r/20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.=
com
> >=20
> > ---
> > Marcos Paulo de Souza (5):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: nbcon: Export console_is_usable
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: nbcon: Introduce KDB helpers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: nbcon: Allow KDB to acquire the =
NBCON context
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: nbcon: Export nbcon_write_contex=
t_set_buf
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kdb: Adapt kdb_msg_write to work with NB=
CON consoles
> >=20
> > =C2=A0include/linux/console.h=C2=A0=C2=A0 | 55
> > ++++++++++++++++++++++++++++++++++++
> > =C2=A0include/linux/kdb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++=
+++++++
> > =C2=A0kernel/debug/kdb/kdb_io.c | 47 +++++++++++++++++++++----------
> > =C2=A0kernel/printk/internal.h=C2=A0 | 45 -----------------------------=
-
> > =C2=A0kernel/printk/nbcon.c=C2=A0=C2=A0=C2=A0=C2=A0 | 71
> > +++++++++++++++++++++++++++++++++++++++++++++--
> > =C2=A05 files changed, 171 insertions(+), 63 deletions(-)
>=20
> With the two below compilation fixes, the series seems to be ready
> for
> linux-next.
>=20
> I am going to wait with pushing a week or so to give other printk and
> kdb maintainers and reviewers a chance to look at it.
>=20
> The following two changes are needed to fix build with
> CONFIG_PRINTK and/or CONFIG_KGDB_KDB disabled. I am going
> to do the in the respective patches when committing:
>=20
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 81d2c247c01f..690a5f698a5c 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -664,7 +664,7 @@ static inline bool nbcon_exit_unsafe(struct
> nbcon_write_context *wctxt) { return
> =C2=A0static inline void nbcon_reacquire_nobuf(struct nbcon_write_context
> *wctxt) { }
> =C2=A0static inline bool nbcon_kdb_try_acquire(struct console *con,
> =C2=A0					 struct nbcon_write_context
> *wctxt) { return false; }
> -static inline void nbcon_kdb_release(struct console *con) { }
> +static inline void nbcon_kdb_release(struct nbcon_write_context
> *wctxt) { }
> =C2=A0static inline bool console_is_usable(struct console *con, short
> flags,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 bool use_atomic) { return
> false; }
> =C2=A0#endif
> diff --git a/include/linux/kdb.h b/include/linux/kdb.h
> index db9d73b12a1a..741c58e86431 100644
> --- a/include/linux/kdb.h
> +++ b/include/linux/kdb.h
> @@ -226,7 +226,7 @@ static inline void kdb_init(int level) {}
> =C2=A0static inline int kdb_register(kdbtab_t *cmd) { return 0; }
> =C2=A0static inline void kdb_unregister(kdbtab_t *cmd) {}
> =C2=A0
> -static inline bool kdb_printf_on_this_cpu(void) { return false };
> +static inline bool kdb_printf_on_this_cpu(void) { return false; }
> =C2=A0
> =C2=A0#endif	/* CONFIG_KGDB_KDB */
> =C2=A0enum {
>=20
>=20

Ouch... thanks a lot Petr for fixing my mistakes here. I should have
disabled the configs to double check these counterparts.

> Best Regards,
> Petr
>=20
>=20
>=20
>=20
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20250713-nbcon-kgdboc-efcfc37fde46
> >=20
> > Best regards,
> > --=C2=A0=20
> > Marcos Paulo de Souza <mpdesouza@suse.com>

