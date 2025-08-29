Return-Path: <linux-kernel+bounces-791824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A92B3BC59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F68F7BDF06
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F0131B133;
	Fri, 29 Aug 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exposignsup.com header.i=@exposignsup.com header.b="nHY7z/o3";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ho4+EZMw"
Received: from a27-234.smtp-out.us-west-2.amazonses.com (a27-234.smtp-out.us-west-2.amazonses.com [54.240.27.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F12EB869
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.27.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473494; cv=none; b=s7q7DKSgzdofO40fLp2+qXN3GxVe6kn6cWjx+5UaRZGcpymKth3JcyobFvv+DoBUR3PyueZ1TG4L5S2dq4Al1RWz8fm1EJhtU/pmUW0x7ASemWAS/IztxmRWCUFOFWyezrZBycOd8Dc51e7aulWqv7PvlgHMeOWGYlMWezx+CUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473494; c=relaxed/simple;
	bh=bxNQvXlQ+rrT5BtlVi0QOH0zoF68sk70GRmprA4Diag=;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:
	 Message-ID; b=ICmdTtZv7N4T6+NsJ3/rFL0fnRpmAuXl+4dmukyG8D4qN4lxD5OcHghLo4sQIVTDJDaC7pqkQVDojMiz9c08rHF4yA05wILQAWYWLWsmH4KdLHMTWZEgkm54dQrFXztYhbVMWsit6c2lX07Fa1Durnid1RTzpRDTt/HfcKCDsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exposignsup.com; spf=pass smtp.mailfrom=us-west-2.amazonses.com; dkim=pass (2048-bit key) header.d=exposignsup.com header.i=@exposignsup.com header.b=nHY7z/o3; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ho4+EZMw; arc=none smtp.client-ip=54.240.27.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exposignsup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us-west-2.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iaprdj6uqabf4jaoepojcwf3vfsb6kkd; d=exposignsup.com;
	t=1756473492;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
	bh=bxNQvXlQ+rrT5BtlVi0QOH0zoF68sk70GRmprA4Diag=;
	b=nHY7z/o3V8Caeyqo1C+lhhdiIyMiAU/85AH8AUNm6G+tD/lE8EP985SbNaif6e0s
	NmgMlqTeD9b0XUfVLufMHu4WPrhPPMrTjRctFeYBhtK1v5BNXkJoq2+XKErTwUJ52ab
	ECNkSqD1WxtfCk2HlP/r25swqY9cDzvuzpHct5pNTevkuUoWhsaK80ACu4wqw3a3cI2
	OzfgcDEytG4aZBnd2kE3c+LE8IaoSa9nNTZTR9cmeYTWUCe2LOVyDviK9mzkjyC4l29
	SLLY4ebx2thIO+TtdgWkgvDtu8sijB3W+zbtXkT/WPjT5oC3oIKKiycPd5C36817Jsy
	ldQfC/QItg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1756473492;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
	bh=bxNQvXlQ+rrT5BtlVi0QOH0zoF68sk70GRmprA4Diag=;
	b=ho4+EZMwnVofpol26UODFeaklZP64GMCPogCmqCiu+SoIO4qKL/rZsKjrFn2X1e+
	BJOw4EDoAiUBo/2lupiclmf02VUvEwV2yak8r4CCRjph9W1759/U+VXONgdnOLF7HaF
	MPVVHdIRynQTg1xjLR4VFCbeC+RuCzsBTJS3caNo=
Subject: Electronics & Applications 2025
From: =?UTF-8?Q?Raquel_Murillo?= <raquel@exposignsup.com>
To: 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>
Date: Fri, 29 Aug 2025 13:18:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="=_jyqIBHAIA1MkYkGfAowQZliAb63dJO9Es7yz5afk3DvoS47l"
References: 
 <!&!AAAAAAAAAAAYAAAAAAAAALJIkL+WjR5DsbCyZIvJycfCgAAAGAAAAAAAAACdBBByhQwoSKBzeJ52Mz6DpAB4AAEAAAAA@exposignsup.com>
X-Priority: 1 (Highest)
X-Mailer: Amazon WorkMail
Thread-Index: AdwY51nf3afL/kLATBWA0mmBjSbbnA==
Thread-Topic: Electronics & Applications 2025
Sensitivity: Personal
Disposition-Notification-To: =?UTF-8?Q?Raquel_Murillo?=
  <raquel@exposignsup.com>
X-Wm-Sent-Timestamp: 1756473491
X-Original-Mailer: Microsoft Outlook 14.0
X-Msmail-Priority: High
Message-ID: <01010198f5fa83a2-149b3b66-be1a-4876-8aa8-915747aa4046-000000@us-west-2.amazonses.com>
Feedback-ID: ::1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
X-SES-Outgoing: 2025.08.29-54.240.27.234

This is a multi-part message in MIME format. Your mail reader does not
understand MIME message format.
--=_jyqIBHAIA1MkYkGfAowQZliAb63dJO9Es7yz5afk3DvoS47l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Exhibitor/Sponsor,

 

Electronics & Applications 2025 attendee contact details are now ready. You
can connect with them to explore potential business opportunities.

 

Please reply with one of the options:

 

1. Yes, send pricing and details

2. No, please remove me

 

Best regards,

Raquel Murillo - Events Manager

Electronics & Applications




--=_jyqIBHAIA1MkYkGfAowQZliAb63dJO9Es7yz5afk3DvoS47l
Content-Type: image/jpeg; name=image001.jpg
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=image001.jpg
Content-Id: <image001.jpg@01DC18C4.222307D0>

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8l
JCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIo
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAAR
CABMAGgDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAA
AgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkK
FhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG
h4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl
5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREA
AgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk
NOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOE
hYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk
5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD2aiq93dpaR7m5Y/dX1rHm1C5lP+sKD0Xi
vOxeZUcM+V6y7I3p0JVNeh0FFcwZpD/y1f8A76NN82T/AJ6P/wB9GvP/ALcj/J+P/AN/qb7n
U0Vl6KzMk25i3I6nNVdTv5JZmhjYrGhwcH7xrvlmEI4eNZrfZGSw8nUcF0Nsyxg4Mig+mafX
IEe1WrC/ktJVBYmIn5lPb3FctLOFKVpxsvU2lgmleLOlopMjGc8Vyt5eyT3ckiyOqk4UBiOK
9DF4uOGim1e5z0aDqto6uiua0q9eK+USSMUk+U7mzg9q6WqwuJjiIcyVhVqLpSswooorqMTn
r+YzXjnPCnaPwqxpdmk+ZpV3KpwFPQms9juJPqc1PBfXFvH5cbALnP3Qa+Ho16X1l1q6utX8
z15wl7PlgdAEQDAUAewpdq/3R+VYJ1S8/wCeg/75FH9q3n/PRf8AvkV7yzjDdn9y/wAzj+q1
O5vAAdBiuWuUaO5lRuoc11OcLk8DHNc7qdzFc3G6JeAMFv71LOIwdKLvrfYrBt8zJIL+GLTH
t2jzIcgccHPc1nKjOwRRlmOAKWtjRIbZlMo+adeoP8P0ryqKni5xpNpWVvl+rO2TjRi5rqT6
pObXTvLB+dxsH9axtNtRd3ojYZRQS1S6xc+felQcrF8o+vetDQrfy7VpiOZTx9B/k13u2Kxq
j9mP6f8ABMF+5w9+rMGeJoJXibhkbGa6nT7n7XZxy/xYw31HWsjX7fZOlwo4kGG+o/8Arfyo
0C52TvbMeJBuX6j/AOt/KnhW8NinSez0/wAiqy9tQU1uv6Z0FFFFfQHlHLyLskZD1ViK09Nt
La4td0kYZwxBOTUWrWrRy+eo+R/vexqvaXkloxKYKnqp718bTUMJi3GvG8fS/oz1ZN1aV4PU
2P7Ms/8AniPzNJ/Zln/zxH5mq41pMcwN+BFH9tx/88X/ADFe0sRlv93/AMB/4BycmI8/vJdX
kMdiQvG9gp+lYdvF59xHFnAdsE1qT3K6nZyrGhV4sOFPcVkKzIwdThgcgjtXmZhUjUrxqLWN
v11OvDxcYOOzNLU9MWGPzrdflUfOv9azbe4ktplljOGH6j0rQ/tyfy9pijLY68/yrLJySeBk
9qzxU6HtFUw7t+FmaUYz5XGoXr23jni+3Wo+Rj+8T+4ahTVLyNFjSbaqjAG0UlndtZzbsbo2
4dP7wrbi0/TZ41kjgVlYZBya6KFOWIblRlyy6rVfNW/pEznGkrVFddDBuL+6uYvLmk3LnONo
FQRSNDKkqfeQ5FdR/ZNh/wA+y/ma57Urb7JevGowh+ZPoaMTha9FKpUlf7y6FanU9yKsdVDK
s8KSpyrjIorK8P3O+F7Zjyh3L9D/APX/AJ0V9Bh6qrUlM8qrT9nNxNdlDAqwBB6g1Ql0eFyT
GzR57dRWhRRWw9KurVI3JjOUPhZknRG/5+B/3z/9ek/sRv8An4H/AHx/9eq4YyX8/wBoMRdZ
sKJbhkIXthe9Bu2TRZIkmxOsjB13fOq7+ffpXH/ZeE/k/F/5k/Xqnctw6TLBKJY7kBh/sdf1
p9zo8M5Lo3lOeuBkE/SqDlY4PkaKONpEErw3DOQmTnPp9auTW1g2n3DW7B/LUtlJicHHHetV
gcOocnLp6sPrdRu/X+vIg/sKXP8Ar0x/umrVto1vDzJmZv8Aa4A/CqUlsoTTkijLmYFmVpWG
47R3qOJs+THcSGO3a4cPHvP7sgcKT9eaVPAYam7qP36hLHVXoyw/h/LnZcYXPAK5xVvT7Cax
LD7QHjb+HbjB9RWXKN8xt7adhb/aUEbhidrbTkA9xnFOFzJNdMXyji4gV1zwGGQfwqqeDoU5
88FZ+rJljqklyyOhqhqWmC/MbCTy2TIzjORVWxFtNl7mfF75jDDyEFTk4AXP0qvA0dtJB5nk
3EhkC747pmYknrtroqQjVjyzWhEMRKDUoluz0Z7O6SZbkHHBGzqPzorWoopUYUY8sFodFSpK
o7yEYkKSBk44Fc7rGsXVpFHDDdQwXEzHDTgAKFGT19Tx+NdHVZtPtpL03kke+Xy/LBbkBc54
H1pzg5NNOxhU5nBxju+pzt5rZun0yWO5FtDdW7SMwtvOYMCOMYJ65qE6xf4szcT/AGXznmUz
/Y9zyKuNrbMZGcmuit9GsrS6FzDGyupcqNxwN5BbA+oqxJZwy3kN26kywBghz0DYzx+FVZnF
7GtK7ctdO/lf9dvvOf0rUb2S9s4JlURTvOu8weWZ0UAq209OppdR1W5s9QvbS3WJQTbxxZjG
FMhIJPr0rbvtNttQEfnq4aI7o3jcoynvgioW0KwkWVZY3l86NEcvISSE+6c9c+9FmN0qqXKp
fP5W/MguZZ9E0u5vLy8W6aNf3IMSx7W6AcepIrGfVb6TRbyZL+3e4snCzeXErpOGI2t+RI/C
t9dCswEDtcTKkgkCzTs43DOOp96dc6Hp900rSQlfOjEcgRioYA5HA7570WYTp1ZL3XZW7v77
/cY1/qN7osjRPLHciKyedcwqg37wB07DNSXFxqWmT232i7juxdxvn9wqlHVCwIx1HHetqfS7
O6uDNPFvYwmAgk4KE5IxVaDw9YQPu/fSkRmNPNmZ/LUjBC5PHFFmEqVVS0enTV6f56GNZ63e
SjTo7hYjeSyqXOwfvY2QspHpyMH6UthfXcc1s+oXEto8kgV4zp21Mk/dD+/rW5/Ylhusm8k7
rFdsDbjkDGMH1qNfD9iJY5JGuZvLYOqy3DuoYdDgnFFmQqVZNXlf5vyNSiiiqPSP/9k=
--=_jyqIBHAIA1MkYkGfAowQZliAb63dJO9Es7yz5afk3DvoS47l--

