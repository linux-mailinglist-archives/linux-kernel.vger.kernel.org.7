Return-Path: <linux-kernel+bounces-776165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64937B2C97B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5128A3B0A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F1255E53;
	Tue, 19 Aug 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rstKt7PJ"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC524A07C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620550; cv=none; b=ByjBi11HYEnQwip+Z48sBa63taLl5Ceu0vU3/QhUU4+nV9USzSxif3irO6kUaX/YwLk0HG03Z2Vi133h++WRXLAIfbrX/lziDrjuZtYjefoDmijLLqV1huR7WaoMxOqq7Wfu9U1CvOX5j6SbErsT6We+35vyYC1WFaNhxLxaZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620550; c=relaxed/simple;
	bh=zpPa4UFCjPXjiiBRhKgfaQ1wA6dchlUKI5VvYXjfAp8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Mo9/XKvknNrVp1VcB8u8FKv3h/MpGL61xyZsNnsM7StmgfpKH1xaqVt87qpWDdfPQfDhxGPOF0V2yzKKYTGvVy9DKEaKGBWRLlJiNa/AHl9P1PpzfKNwOW0ySITMPKWA3PhZl73xO2CDRK/Zq78UxTx7QS25BnnfqoTBrMCmbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rstKt7PJ; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1755620234;
	bh=waUr6sdLzupbNbnuNAzT8J6vSktpO6KGY7bLPkUM2oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rstKt7PJlp9p5xcApXXdbUMDIcNSYNQdWQg9+ckN0ZU+0EBsfcGDXCiki7e+H1OXM
	 4atmjjwXTKD58tP7SrjWis3UkClXX+bQ6gRRCoiAHzn2O52qcYyl16vrjAkyV9UEmR
	 OCipJ0NHtP3Smi0497HyIf8oUWyF6ioqWafpu4tA=
Received: from zm.. ([2408:8340:a29:3fc0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 44C8260F; Wed, 20 Aug 2025 00:17:12 +0800
X-QQ-mid: xmsmtpt1755620232tlukdyywg
Message-ID: <tencent_93CE617328A1683191A7418BCCE87AFE500A@qq.com>
X-QQ-XMAILINFO: NS0ZUBiNXRl8hnigUPuzt7zBrviPbCAr9rZQZ+jwhJHIsKoGCuJNLOrGsC+OtG
	 Ye5koxY0Gk3TRO/LX3nOXbP+WpOMeQIuEXg8GB66yuG6g5pnKojHqs754cZLSOkutR6G7tMALDEp
	 z5rnbFeC/nycbnLUFD41nZHe4flIitKPwYRb2l6tASGa/OKK502DWgQGcIKJT+r85ZAJTwQUKJoh
	 HmsiOsDeHLu2I/fhdamrHum+RHsJDZs+ao3HkAwGt1WXmUcyG7juWgqYfdNp326M+bvsLi36TM6X
	 naKNVOEzEYPou9b6/PEdHj9ra4l6lgWaCBqHBfJS4W5BxcIupJELFHBLBVasfS0fWLRKH6u4ov71
	 ifqK+ADcGD9i93in90HdBuNDKCjuEQxfZJnq1G8INO8XTSD+aMl0vIBMlcloIIGIzUloTU8UqZgD
	 oo+3Z19WWad5QH02K10nhROvxOg5+V1ANKWyVkjFrcyJCyqYb/kbln5Ca2u9I7JFC3N24LDvjhRW
	 YS6Lz2Y8WopjihKesz65r3ZMkqOo0wCBjvIf2T4WVivryWfxsqb8X1C3q0loAeivwpDkEjzXdhYc
	 vr6xxhnMABmY8Xc/5qeywuPg9HUPZ7muLHin6ksTLWAiBeDrnJQd1ZCXicdcAOmfnrbm8L8K93F5
	 yTvNJdMHN23vEhh8eF3X4gpScZxE2CO/TgEanehfT27ROXAO2OxxrtVy/VVFMEpDctlEFUtLOfDi
	 NtnQsWnjElaG2TLkawma3BYWsx+szlQ/oYPGltvOkbBfb0FFFboZESSnG2rkuk8Sl6rjC3F3y5c6
	 Tty+0q/+8Y6II/XMtdBkflDAwZJuHlC4jIF+Jjn9tPbVCv3D6nY5sRdTKvcFMPWI7Hwve7iSw5TG
	 aO5/ri19czU3JfnNSljm+eE3xllCPKTKkZGNKvnUx0Z6v3S5i6qOwBIdVu9LyZ14KN+fkIaaUCG/
	 bDWZu26JZ4nuQeLNZzBBfZ2bxJMyEOXN2lbu6M5YQsw1xwTgHLC4gcpTuEMUDg17FCg2Nyv6AKh3
	 tnjcW+OtxIMgrDT1wr
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: zhoumin <teczm@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	teczm@foxmail.com
Subject: Re: [PATCH] vfat: fix uninitialized i_pos error
Date: Wed, 20 Aug 2025 00:17:12 +0800
X-OQ-MSGID: <20250819161712.1720839-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87o6sbz5kd.fsf@mail.parknet.co.jp>
References: <87o6sbz5kd.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi OGAWA-san,=0D
=0D
Thank you for your review and feedback.=0D
=0D
>> The i_pos field remains uninitialized when fat_fs_error_ratelimit() repo=
rts=0D
>> error, e.g.,=0D
>>=0D
>> 	[ 1642.703550] FAT-fs (loop0): error, fat_get_cluster: invalid=0D
>> 	cluster chain (i_pos 0)=0D
>>=0D
>> Since i_pos is assigned in fat_attach after fat_fill_inode, the error=0D
>> message lacks useful debug info.=0D
>>=0D
>> Path:=0D
>> vfat_lookup=0D
>> 	fat_build_inode=0D
>> 		fat_fill_inode=0D
>> 			fat_calc_dir_size=0D
>>           			fat_get_cluster /* report error */=0D
>>       	fat_attach  /* i_pos assigned here */=0D
=0D
> No. It is initialized as 0, and it must be unavailable outside=0D
> between fat_attach and fat_detach.=0D
=0D
I see that it was initialized to 0. What I meant is that when=0D
fat_fs_error_ratelimit uses i_pos for debugging output, it doesn't get the=
=0D
correct value.=0D
=0D
> IOW, this is introducing the race.=0D
I'm not quite clear about the race condition you mentioned here. Could you=
=0D
give an example to explain it?=0D
=0D
Actually, the modification I initially considered was as follows. I'm not=0D
sure if this approach carries any risks. If it's acceptable, I'm ready to=0D
submit a new version.=0D
=0D
Thank you.=0D
=0D
=0D
diff --git a/fs/fat/inode.c b/fs/fat/inode.c=0D
index 3852bb66358c..837b1ad361ca 100644=0D
--- a/fs/fat/inode.c=0D
+++ b/fs/fat/inode.c=0D
@@ -605,13 +605,14 @@ struct inode *fat_build_inode(struct super_block *sb,=
=0D
        }=0D
        inode->i_ino =3D iunique(sb, MSDOS_ROOT_INO);=0D
        inode_set_iversion(inode, 1);=0D
+       fat_attach(inode, i_pos);=0D
        err =3D fat_fill_inode(inode, de);=0D
        if (err) {=0D
                iput(inode);=0D
+               fat_detach(inode);=0D
                inode =3D ERR_PTR(err);=0D
                goto out;=0D
-       }=0D
-       fat_attach(inode, i_pos);=0D
+       }=0D
        insert_inode_hash(inode);=0D
 out:=0D
        fat_unlock_build_inode(MSDOS_SB(sb));=0D
=0D
Best regards,=0D
zhoumin=0D


