Return-Path: <linux-kernel+bounces-826967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBDB8FC06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 941C27A10FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793DC284B33;
	Mon, 22 Sep 2025 09:28:35 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E96188734
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533314; cv=none; b=slDFxI1chDOfscb7evEmHixqfDQ2W4y3s9B9hy7brIvlWbpt5rLZN+mllFUvmGvWWi4BsqvITCVLfqhVoGZhK8FRUTW2BuIakLJIaZr1p6ws6F6foFHEDJ3V2zvrElJPRByNuzjw+mz/U9I9oHQFNag722xN/6E4bQCE3JcEuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533314; c=relaxed/simple;
	bh=W5K1IUbRgJy/ZKktgMNeYGAeCta99Nb5H7oKJP4QUEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fke0FrgFi88XhFgl54OBjW3f1bj+j7H3vSq5m/HoS0/y19xy29/g+B0O+uQJNi3ZFLL5oshnW57KePKuFPTTQnzcyX1vt5v3JDoGFZKlSuUOSFVGm7xZ4m/+qduvCoc7iziTXjJJFpl/aynjEm5odWfwz7s0RlcQVQ4RDOd3KpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201623.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202509221728181176;
        Mon, 22 Sep 2025 17:28:18 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 17:28:17 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.058; Mon, 22 Sep 2025 17:28:17 +0800
From: =?utf-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?=
	<liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
Thread-Topic: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
Thread-Index: AQHcKfR9YxX0s+2XBkmHD0nyW5TlP7Sd7BwAgAEGVeA=
Date: Mon, 22 Sep 2025 09:28:17 +0000
Message-ID: <7eb749216aaf43c8bac99fb1755d032f@inspur.com>
References: <0edc7fad4f38136ffbf88c9c67835d0922-9-25linux.alibaba.com@g.corp-email.com>
 <47107a3c-44d5-4937-bc35-2e01605bdb98@linux.alibaba.com>
In-Reply-To: <47107a3c-44d5-4937-bc35-2e01605bdb98@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_000C_01DC2BE6.470DA020"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
tUid: 2025922172819ecb437e303ceee173e4adbe77693dec9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

------=_NextPart_000_000C_01DC2BE6.470DA020
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Gao Xiang <hsiangkao@linux.alibaba.com>
>Sent: Monday, September 22, 2025 9:49 AM
>To: Bo Liu (=E5=88=98=E6=B3=A2)-=E6=B5=AA=E6=BD=AE=E4=BF=A1=E6=81=AF =
<liubo03@inspur.com>; xiang@kernel.org;
>chao@kernel.org
>Cc: linux-kernel@vger.kernel.org; linux-erofs@lists.ozlabs.org
>Subject: Re: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
>
>
>
>On 2025/9/20 14:04, Bo Liu wrote:
>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>
>> Add support for reading to the erofs volume label from the
>> FS_IOC_GETFSLABEL ioctls.
>>
>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>> ---
>>
>> v1:
>>
>https://lore.kernel.org/linux-erofs/63904ade56634923ba734dcdab3c45d0@i
>> nspur.com/T/#t
>> v2:
>> =
https://lore.kernel.org/linux-erofs/20250826103926.4424-1-liubo03@insp
>> ur.com/T/#u
>>
>> Changes since v2:
>> - remove unnecessary code
>>
>>   fs/erofs/Makefile   |  2 +-
>>   fs/erofs/data.c     |  4 ++++
>>   fs/erofs/dir.c      |  4 ++++
>>   fs/erofs/inode.c    |  5 +----
>>   fs/erofs/internal.h |  7 +++++++
>>   fs/erofs/ioctl.c    | 41
>+++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/super.c    |  8 ++++++++
>>   7 files changed, 66 insertions(+), 5 deletions(-)
>>   create mode 100644 fs/erofs/ioctl.c
>>
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile index
>> 549abc424763..5be6cc4acc1c 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>
>>   obj-$(CONFIG_EROFS_FS) +=3D erofs.o
>> -erofs-objs :=3D super.o inode.o data.o namei.o dir.o sysfs.o
>> +erofs-objs :=3D super.o inode.o data.o namei.o dir.o sysfs.o ioctl.o
>>   erofs-$(CONFIG_EROFS_FS_XATTR) +=3D xattr.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP) +=3D decompressor.o zmap.o zdata.o =
zutil.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) +=3D decompressor_lzma.o diff =
--git
>> a/fs/erofs/data.c b/fs/erofs/data.c index 3b1ba571c728..8ca29962a3dd
>> 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -475,6 +475,10 @@ static loff_t erofs_file_llseek(struct file =
*file, loff_t
>offset, int whence)
>>   const struct file_operations erofs_file_fops =3D {
>>   	.llseek		=3D erofs_file_llseek,
>>   	.read_iter	=3D erofs_file_read_iter,
>> +	.unlocked_ioctl =3D erofs_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl   =3D erofs_compat_ioctl,
>> +#endif
>>   	.mmap_prepare	=3D erofs_file_mmap_prepare,
>>   	.get_unmapped_area =3D thp_get_unmapped_area,
>>   	.splice_read	=3D filemap_splice_read,
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c index
>> debf469ad6bd..32b4f5aa60c9 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops =3D {
>>   	.llseek		=3D generic_file_llseek,
>>   	.read		=3D generic_read_dir,
>>   	.iterate_shared	=3D erofs_readdir,
>> +	.unlocked_ioctl =3D erofs_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl   =3D erofs_compat_ioctl,
>> +#endif
>>   };
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c index
>> 9a2f59721522..a7ec17eec4b2 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -213,10 +213,7 @@ static int erofs_fill_inode(struct inode *inode)
>>   	switch (inode->i_mode & S_IFMT) {
>>   	case S_IFREG:
>>   		inode->i_op =3D &erofs_generic_iops;
>> -		if (erofs_inode_is_data_compressed(vi->datalayout))
>> -			inode->i_fop =3D &generic_ro_fops;
>> -		else
>> -			inode->i_fop =3D &erofs_file_fops;
>> +		inode->i_fop =3D &erofs_file_fops;
>>   		break;
>>   	case S_IFDIR:
>>   		inode->i_op =3D &erofs_dir_iops;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h index
>> 4ccc5f0ee8df..311346a017a7 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -166,6 +166,9 @@ struct erofs_sb_info {
>>   	struct erofs_domain *domain;
>>   	char *fsid;
>>   	char *domain_id;
>> +
>> +	/* volume name */
>
>The comment is useless, just drop this line.
>
>> +	char *volume_name;
>>   };
>>
>>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info) @@
>> -535,6 +538,10 @@ static inline struct bio =
*erofs_fscache_bio_alloc(struct
>erofs_map_dev *mdev) {
>>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>>   #endif
>>
>> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long
>> +arg); long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>> +			unsigned long arg);
>> +
>>   #define EFSCORRUPTED    EUCLEAN         /* Filesystem is
>corrupted */
>>
>>   #endif	/* __EROFS_INTERNAL_H */
>> diff --git a/fs/erofs/ioctl.c b/fs/erofs/ioctl.c new file mode 100644
>> index 000000000000..fbcbf820c4d7
>> --- /dev/null
>> +++ b/fs/erofs/ioctl.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later #include <linux/fs.h>
>> +#include <linux/compat.h> #include <linux/file.h>
>> +
>> +#include "internal.h"
>> +
>> +static int erofs_ioctl_get_volume_label(struct inode *inode, void
>> +__user *arg)
>
>Can we just move these functions into inode.c instead?
>
>Since there is no need to introduce a new file just for a few new =
lines.
>
>Otherwise it looks good to me.
>
>Thanks,
>Gao Xiang

Thanks for your comments.
I will send the next version of the patch later.

Thanks,
Bo Liu

------=_NextPart_000_000C_01DC2BE6.470DA020
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
hkiG9w0DBzAdBgNVHQ4EFgQUsmXTjDrO/nhxGDpnz5cAr1neWI8wHwYDVR0jBBgwFoAUXlkDprRM
WGCRTvYetaU5pjLBNWowggEPBgNVHR8EggEGMIIBAjCB/6CB/KCB+YaBumxkYXA6Ly8vQ049SU5T
UFVSLUNBLENOPUpUQ0EyMDEyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1T
ZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NlcnRp
ZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2lu
dIY6aHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSU5TUFVSLUNB
LmNybDCCASwGCCsGAQUFBwEBBIIBHjCCARowgbEGCCsGAQUFBzAChoGkbGRhcDovLy9DTj1JTlNQ
VVItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNl
P29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwZAYIKwYBBQUHMAKGWGh0dHA6Ly9K
VENBMjAxMi5ob21lLmxhbmdjaGFvLmNvbS9DZXJ0RW5yb2xsL0pUQ0EyMDEyLmhvbWUubGFuZ2No
YW8uY29tX0lOU1BVUi1DQSgxKS5jcnQwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgor
BgEEAYI3CgMEMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYKKwYB
BAGCNwoDBDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJs
aXVibzAzQGluc3B1ci5jb20wUwYJKwYBBAGCNxkCBEYwRKBCBgorBgEEAYI3GQIBoDQEMlMtMS01
LTIxLTE2MDY5ODA4NDgtNzA2Njk5ODI2LTE4MDE2NzQ1MzEtMjU4ODUyMzQ4MA0GCSqGSIb3DQEB
CwUAA4IBAQAucjq5s0Qq1UtBIL8Und9mnrfn3azil+rXBoZf/N+DNuZYml+Ct4SDC0tng7F5kSt/
2zU4vShrkviUh8kjCstCrPyqkxQodvm7reuGuBKZLy9PLZR0oB3S7vD9gUdMCw7UianFwY+mgbG/
33dY43zujZIY8DMm6od3GMZlIueeqB6VyEESU4+ll2VFPyLXPzUMBK7DLAEnOiPbJSUvR7738lSk
DPXxdujcFhL9wxTvh/3ghYuY0OCwf+HM7TFBSSFxa1wdkfO8aA9Bl6tY5awZ6bbsr+3+FRf/h1jW
ZQOCCnEGixEPN0irb1ZjdI2O4u1TlTwZAYXdLVRqmr2vi1KHMYIDkzCCA48CAQEwcDBZMRMwEQYK
CZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZ
FgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQADjuUwCQYFKw4DAhoF
AKCCAfgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUwOTIyMDky
ODE0WjAjBgkqhkiG9w0BCQQxFgQUZD2p+d7RIoejqXHHQRZmHPv2U0gwfwYJKwYBBAGCNxAEMXIw
cDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJ
kiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQADjuUw
gYEGCyqGSIb3DQEJEAILMXKgcDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQB
GRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34A
A47lMgPE5azBUewAAQADjuUwgZMGCSqGSIb3DQEJDzGBhTCBgjAKBggqhkiG9w0DBzALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJ
KoZIhvcNAQEBBQAEggEAYEjEjOw93Uu5j5/yyy7JZYQDIj6l47/jLcSxdqWJe6be74CEZCRpJeqk
sEoEmqRU56JNmd4pcpy95NRbh3gaDigW3CVg68tcaT/uurIQt++/HCx9Jql8/YoWm5Ujjh/FLe/z
LmONGpfo3vHcGmvTRliG1Ckk3f6p1gc0bxJ4lboaBXTm2LZdKcAAQwVyaSlJ4sabDktkgvdCkCJS
ZRqnn0Vtm8+yVVy+KAmjfbX1OppB+QwOj/Dt45bc5eg1Qh78FRVarNlJZF97W8wi0aWXTeEZ1yEa
IwjKwdO2Lk4dRfkX5qPgMRGEqcp0IN8DXGpSEe3tiIRIKX+0VFZ9WmlIKAAAAAAAAA==

------=_NextPart_000_000C_01DC2BE6.470DA020--

