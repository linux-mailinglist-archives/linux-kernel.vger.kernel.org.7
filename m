Return-Path: <linux-kernel+bounces-854293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5193FBDE02D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C995D34981C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF531CA5E;
	Wed, 15 Oct 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GfChM3vd"
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE231A560
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524194; cv=none; b=iKEN4saHftfaJhuI5fLHjFJygVkY8LLEoY1xK0UjaP/tFnboUMTzr6+SzVjz/Aw1+el2UrNaIONucTIq4EUDpBNBRMOBAV+M2WIqvnUOwjpf8wAC5mY+lGMM0ct3hqVSOzxwl7E2YpNJSB3pt0qQjXh67BZ4WQQ1PhIEezb84ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524194; c=relaxed/simple;
	bh=wcgkdeVSto3NF4ROD1o9gUX0UOla7C8owV+HERpAq94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4+dUifmJ3fsn7nyHQ0cFhFqbOdWq1pb0RkKQsNi8QogZyVp9o8r3k2KscSu15aosJTCECgsKPCWud9HT+PEwUbADbWlseJfkE2pik4i8eCjAsI+xR7loot/wH+shq9W7nTq5Uck0XRov21poeeiJwXyaDGFmR1wVRXy5Z6JXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GfChM3vd; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-88703c873d5so220190439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524192; x=1761128992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vob8406hRx5Tlv6u3EdB1Ym+K4txyoEExWNyQ34T+dQ=;
        b=lUbDM0+jS6XDmcF4TJVBe2j0lFNfkDiBWZR+sSxEhA3xK+VrprcdZrviewuImJ/rzz
         fkIheQSydM0FvOFlsf4QJJfbJtDRvR4cE6xJjRGcQZLazZNmoxCUDhGA0f81zS5xRoH6
         lTcKHLTGTS/E29Kn26zGxFHLyJbYLGEtqTQuA5kLFiN7d1Ffa9TpnhDt77svvsqzoydx
         TPciej2uoyTqA4awkr4C5scY8NfRmGMuGlTHgrxovyd3bc9epBqYYd0Nvf/EcgLt5piI
         TDWVT1vTTYlN5gLMZ/4FtAa5O6PIaDCBR6juMBsT75A7CKoyOb5idar0aXAaRCBWAKz+
         Hejg==
X-Forwarded-Encrypted: i=1; AJvYcCUbHx3v/0Lm+YEEQtHtes75GRs4CPzrr9zZLAAwpcrBs6EiZ7ik152FbXTWoowEtDNSLCYgycjnFdAqn1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6+amEdMx2zwqUpqaMiOtDSHHo64LGprCqpEU2GUMOzuWoXOr
	EL4HEMtMQNscgVw7KVrk8deqrVqXp74ThX96ueQ0lyXa82i8cfeKcOMrd8y6AO0rAuXDI3WjmBc
	Kisi81bmuHIMx6AtAp2mXu+cXewShvCzTUROKWsXAlwXbusFW3WGig+Sog7q396CJP59DuoXuwz
	jLpmP+V6BPnUdzqY/vXOwJL5vC3aHrvj35c6sQFHxFGb3XbQ4IcoElHxxhkHGaMDc4BbfSVF/Sg
	n39ha19g46G0Z5/t+A=
X-Gm-Gg: ASbGncvxkJyYF+372iewrgGJeU1/bUe6W2uruDkDh+6GCxTxsWbUfLqlyEwLv0bkvEm
	m1wh0ASMUbRVpHu+85DDp7rOvp6D09SAAvu/0k26kdpA0gH3z+UX0RrEDJDV3Dr8Ed8+OER1Ku4
	VxK14G/ZHdzfLvm2+/zKONWAZAResqJPb9tSACdc30p567CFlnSGNXMhOV3GqQmP4VOpJa0/Rp7
	kzHzr3Ur0o+Iwj4AFpam9pG2K49kTLG/KyjjP+gsUtLmp4OVTooAq9jRFLVVM9RfUpp9hDCVwvJ
	ZdQJiZeBlq/yCNg/eSkL+kpgOqfRv7o4MiJJasGwRMJVOV6w3nrNt2O9BotvuQi+zowa58a1bId
	ENZwI2+Ev50/hBRUAaeJCHUz+TAIQyjfPKseJ2wIkL2p/aQSfufQP0vOTV7ml3zRiZAOXpO3r36
	0=
X-Google-Smtp-Source: AGHT+IGQUjBQKU/x5OM0dtwl1CeVC9cE/IJQT8Oq1xTp5RGWuIHDJgbt0zINkhPwy786NSLVISL6j9aHikMe
X-Received: by 2002:a05:6e02:1646:b0:42d:7dea:1e04 with SMTP id e9e14a558f8ab-42f873fb8efmr282824575ab.25.1760524191679;
        Wed, 15 Oct 2025 03:29:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42f9025e4c5sm11370275ab.9.2025.10.15.03.29.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Oct 2025 03:29:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780fb254938so8481741b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760524190; x=1761128990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vob8406hRx5Tlv6u3EdB1Ym+K4txyoEExWNyQ34T+dQ=;
        b=GfChM3vdUxDJsh/wldTJXr6KrZTZw4x4IYffaYci3JZR6KgdaM724HYqttPXtKDRfN
         BNZChTLVGC8P5LKeBbfdeDmh9KFsdPv3foDQbmyMXBiJ8AGq5DN6FebRD6otxd32qyUg
         lomEmPL/wTv7JmqXvQ/saiv/kZZDA+YytoqjQ=
X-Forwarded-Encrypted: i=1; AJvYcCV3bDk73xW+uppJDMNDv4RrsCot38wX0gp1rYmgh0OyDJz59Yxwwcf1qf81NXlKpcc2kZdQQXDykKRFbFw=@vger.kernel.org
X-Received: by 2002:a05:6a20:2449:b0:306:2a14:d0d4 with SMTP id adf61e73a8af0-32da83e6017mr37874054637.43.1760524189942;
        Wed, 15 Oct 2025 03:29:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:2449:b0:306:2a14:d0d4 with SMTP id
 adf61e73a8af0-32da83e6017mr37874018637.43.1760524189466; Wed, 15 Oct 2025
 03:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760502478.git.zhuyikai1@h-partners.com> <905df406fd870da528361f47c48067802588cfb5.1760502478.git.zhuyikai1@h-partners.com>
In-Reply-To: <905df406fd870da528361f47c48067802588cfb5.1760502478.git.zhuyikai1@h-partners.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 15 Oct 2025 15:59:36 +0530
X-Gm-Features: AS18NWB6wjOop2tYYHm7gUl-Ch7WYa9xLfizjawpwcM4ZcnXv7uj0L9myyZ6qeI
Message-ID: <CALs4sv28UttVJh2vCbax=foQYu83Qn1NsiUWOGQhKHsKg7ZwqA@mail.gmail.com>
Subject: Re: [PATCH net-next v01 1/9] hinic3: Add PF framework
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, 
	Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, 
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, 
	Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, 
	Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, 
	Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fc64c806412ffa9d"

--000000000000fc64c806412ffa9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:48=E2=80=AFPM Fan Gong <gongfan1@huawei.com> wro=
te:
>
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> @@ -314,6 +314,9 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwde=
v)
>                         ret =3D -EFAULT;
>         }
>
> +       if (HINIC3_FUNC_TYPE(hwdev) !=3D HINIC3_FUNC_TYPE_VF)

Is this check needed? Other places hinic3_set_pf_status() is called
without checking. I see the function has an internal check for PF.

> +               hinic3_set_pf_status(hwif, HINIC3_PF_STATUS_FLR_START_FLA=
G);
> +
>         clr_res.func_id =3D hwif->attr.func_global_idx;
>         msg_params.buf_in =3D &clr_res;
>         msg_params.in_size =3D sizeof(clr_res);
> @@ -337,6 +340,54 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwd=
ev)
>         return ret;
>  }
>
> +int hinic3_set_bdf_ctxt(struct hinic3_hwdev *hwdev, u8 bus, u8 device, u=
8 function)

You could just send *bdf_info as a parameter with values pre-set,
makes it look better

> +{
> +       struct comm_cmd_bdf_info bdf_info =3D {};
> +       struct mgmt_msg_params msg_params =3D {};
> +       int err;
> +
> +       bdf_info.function_idx =3D hinic3_global_func_id(hwdev);
> +       bdf_info.bus =3D bus;
> +       bdf_info.device =3D device;
> +       bdf_info.function =3D function;
> +
> +       mgmt_msg_params_init_default(&msg_params, &bdf_info, sizeof(bdf_i=
nfo));
> +
> +       err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
> +                                      COMM_CMD_SEND_BDF_INFO, &msg_param=
s);
> +       if (err || bdf_info.head.status) {
> +               dev_err(hwdev->dev,
> +                       "Failed to set bdf info to fw, err: %d, status: 0=
x%x\n",
> +                       err, bdf_info.head.status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}

<-->

> +static void set_ppf(struct hinic3_hwdev *hwdev)

Any particular reason why this function does not have hinic3 prefix?

> +{
> +       struct hinic3_hwif *hwif =3D hwdev->hwif;
> +       struct hinic3_func_attr *attr;
> +       u32 addr, val;
> +
> +       if (HINIC3_IS_VF(hwdev))
> +               return;
> +
> +       /* Read Modify Write */
> +       attr =3D &hwif->attr;
> +       addr =3D HINIC3_CSR_PPF_ELECTION_ADDR;
> +       val =3D hinic3_hwif_read_reg(hwif, addr);
> +       val &=3D ~HINIC3_PPF_ELECTION_IDX_MASK;
> +       val |=3D HINIC3_PPF_ELECTION_SET(attr->func_global_idx, IDX);
> +       hinic3_hwif_write_reg(hwif, addr, val);
> +
> +       /* Check PPF index */
> +       val =3D hinic3_hwif_read_reg(hwif, addr);
> +       attr->ppf_idx =3D HINIC3_PPF_ELECTION_GET(val, IDX);
> +}
> +

<-->

> +int hinic3_get_default_mac(struct hinic3_hwdev *hwdev, u8 *mac_addr)
> +{
> +       struct l2nic_cmd_set_mac mac_info =3D {};
> +       struct mgmt_msg_params msg_params =3D {};
> +       int err;
> +
> +       mac_info.func_id =3D hinic3_global_func_id(hwdev);
> +
> +       mgmt_msg_params_init_default(&msg_params, &mac_info, sizeof(mac_i=
nfo));
> +
> +       err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +                                      L2NIC_CMD_GET_MAC,
> +                                      &msg_params);
> +
> +       if (err || mac_info.msg_head.status) {
> +               dev_err(hwdev->dev,
> +                       "Failed to get mac, err: %d, status: 0x%x\n",
> +                       err, mac_info.msg_head.status);
> +               return -EINVAL;

EINVAL looks odd. I see other places it is -EIO.


> +       }
> +
> +       ether_addr_copy(mac_addr, mac_info.mac);
> +
> +       return 0;
> +}
> +
>  int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 v=
lan_id,
>                    u16 func_id)
>  {
> @@ -157,9 +189,9 @@ int hinic3_set_mac(struct hinic3_hwdev *hwdev, const =
u8 *mac_addr, u16 vlan_id,
>                 return -EIO;
>         }
>
> -       if (mac_info.msg_head.status =3D=3D MGMT_STATUS_PF_SET_VF_ALREADY=
) {
> +       if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
>                 dev_warn(hwdev->dev, "PF has already set VF mac, Ignore s=
et operation\n");
> -               return 0;
> +               return HINIC3_PF_SET_VF_ALREADY;
>         }
>
>         if (mac_info.msg_head.status =3D=3D MGMT_STATUS_EXIST) {
> @@ -191,11 +223,17 @@ int hinic3_del_mac(struct hinic3_hwdev *hwdev, cons=
t u8 *mac_addr, u16 vlan_id,
>
>         err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
>                                        L2NIC_CMD_DEL_MAC, &msg_params);
> -       if (err) {
> +       if (err || (mac_info.msg_head.status &&
> +                   !PF_SET_VF_MAC(hwdev, mac_info.msg_head.status))) {
>                 dev_err(hwdev->dev,
>                         "Failed to delete MAC, err: %d, status: 0x%x\n",
>                         err, mac_info.msg_head.status);
> -               return err;
> +               return -EIO;
> +       }
> +
> +       if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
> +               dev_warn(hwdev->dev, "PF has already set VF mac, Ignore d=
elete operation.\n");
> +               return HINIC3_PF_SET_VF_ALREADY;
>         }
>
>         return 0;
> @@ -231,6 +269,17 @@ int hinic3_update_mac(struct hinic3_hwdev *hwdev, co=
nst u8 *old_mac,
>                 return -EIO;
>         }
>
> +       if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
> +               dev_warn(hwdev->dev, "PF has already set VF MAC. Ignore u=
pdate operation\n");
> +               return HINIC3_PF_SET_VF_ALREADY;
> +       }
> +
> +       if (mac_info.msg_head.status =3D=3D HINIC3_MGMT_STATUS_EXIST) {
> +               dev_warn(hwdev->dev,
> +                        "MAC is repeated. Ignore update operation\n");
> +               return 0;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/driver=
s/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
> index b83b567fa542..08bf14679bf8 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
> @@ -16,6 +16,8 @@ struct hinic3_nic_dev;
>  #define HINIC3_MAX_JUMBO_FRAME_SIZE  9600
>
>  #define HINIC3_VLAN_ID_MASK          0x7FFF
> +#define HINIC3_PF_SET_VF_ALREADY     0x4
> +#define HINIC3_MGMT_STATUS_EXIST     0x6
>
>  enum hinic3_nic_event_type {
>         HINIC3_NIC_EVENT_LINK_DOWN =3D 0,
> @@ -41,6 +43,7 @@ void hinic3_update_nic_feature(struct hinic3_nic_dev *n=
ic_dev, u64 feature_cap);
>  int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev);
>  int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
>
> +int hinic3_get_default_mac(struct hinic3_hwdev *hwdev, u8 *mac_addr);
>  int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 v=
lan_id,
>                    u16 func_id);
>  int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 v=
lan_id,
> --
> 2.43.0
>
>

--000000000000fc64c806412ffa9d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDYOdWK
oniHaOYZhNAUPuWwWMag0R7Qcqdi3YG2RPC0IDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTUxMDI5NTBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBj0z3FRyeJAainWyZB8ge0TgP3T9alVrixuchtvlyq
2cSV5udlxR6eOM68EUcRLMaqB28S7RBO+HoYfvKakLEAqZtZ7UJHNLFcOZqE4rzHHAgKFPy2VLlA
foxoSdMScSHv73UOZMfRBH7XHOGcm23row4d5UfWJPV/PlR3s1jgmmG61uB/4urVn7PoLq8aHvQC
CKNXXw01TxNAtDjt1Bw4TukovChGd4FQZNLlEpI15BXTqFBXtSyxPlsVrqp23MySuAyOz6Cl75nr
dUxy2ox/4iI401Lagbp62/phOGuGVuu//Ffy75cxmWx3z+wsbR6R2viyym9fhCW318wp3J3v
--000000000000fc64c806412ffa9d--

